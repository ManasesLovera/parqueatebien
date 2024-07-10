import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'placa_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  final TextEditingController _licensePlateController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _licensePlateController.dispose();
    super.dispose();
  }

  Future<void> _getCitizen() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    String licensePlate = _licensePlateController.text;
    try {
      var citizen = await ApiService.getCitizen(licensePlate);
      if (!mounted) {
        return; // Check if the widget is still mounted before using the context
      }
      if (citizen != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacaScreen(citizen: citizen),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Citizen not found';
        });
      }
    } catch (e) {
      if (!mounted) {
        return; // Check if the widget is still mounted before using the context
      }
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(1),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/image/LOGO_PARQUEATE.png',
                      height: 125,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 50),
                    const Center(
                      child: Text(
                        'INTRODUZCA EL NÚMERO DE PLACA DE SU VEHÍCULO',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF010F56),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Placa:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 1, 15, 117),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: constraints.maxWidth * 0.8,
                          child: TextField(
                            controller: _licensePlateController,
                            decoration: const InputDecoration(
                              hintText: 'Ingresar Dígitos De Placa',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                            ),
                            maxLength: 7,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (_isLoading) ...[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                    ],
                    if (_errorMessage.isNotEmpty) ...[
                      Text(_errorMessage),
                      const SizedBox(height: 50),
                    ],
                    _buildConsultButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConsultButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed:
                _licensePlateController.text.length == 7 ? _getCitizen : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _licensePlateController.text.length == 7
                  ? const Color.fromARGB(255, 1, 15, 86)
                  : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'consultar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
