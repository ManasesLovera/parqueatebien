import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Controllers/Reporte/form_controller.dart';
import 'package:frontend_android/Handlers/Reportes/report_handler.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/Widgets/Map_Global/map_global.dart';
import 'package:frontend_android/Widgets/Reportes/report_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Clave global para el formulario.
  late FormControllerReport _formController; // Controlador del formulario.
  late FormHandlersReport _formHandlers; // Manejadores del formulario.
  String? userRole; // Rol del usuario.

  @override
  void initState() {
    super.initState();
    _formHandlers = FormHandlersReport(
      formKey: _formKey,
      plateController: TextEditingController(),
      addressController: TextEditingController(),
      showSnackBar: _showSnackBar,
      showDialog: (message) => _showDialog(context, message),
    );
    _formController = FormControllerReport(handlers: _formHandlers);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formController
          .init(context); // Inicializa el controlador del formulario.
      _formHandlers.getLocation(context); // Obtiene la ubicación inicialmente.
      _loadUserRole(); // Carga el rol del usuario al inicializar.
    });
  }

  // Método para cargar el rol del usuario desde las preferencias compartidas.
  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role');
    });
  }

  @override
  void dispose() {
    _formController
        .dispose(); // Libera los recursos del controlador del formulario.
    super.dispose();
  }

  // Método para mostrar un SnackBar con un mensaje.
  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Método para mostrar un diálogo con un mensaje.
  void _showDialog(BuildContext context, String message) {
    List<String> parts = message.split('|');
    String title = parts.length > 1 ? parts[0] : 'Error';
    String content = parts.length > 1 ? parts[1] : message;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Método para validar el formulario al enviarlo.
  void _onValidate() {
    setState(() {
      _formHandlers.plateFieldTouched = true;
      _formHandlers.vehicleTypeTouched = true;
      _formHandlers.colorTouched = true;
      _formHandlers.addressFieldTouched = true;
    });
    _formHandlers.validateOnSubmit(context); // Valida y envía el formulario.
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Welcome()),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco.
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 0.h), // Alineación horizontal.
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (_formHandlers.latitude != null &&
                        _formHandlers.longitude != null)
                      SizedBox(height: 20.h), // Espacio vertical.
                    const TitleText(), // Título del formulario.
                    SizedBox(height: 10.h), // Espacio vertical.
                    const DatosDelVehiculo(), // Sección de datos del vehículo.
                    SizedBox(height: 30.h), // Espacio vertical.
                    const NumeroPlaca(), // Título del campo de número de placa.
                    PlateWidgetReport(
                      controller: _formHandlers.plateController,
                      touched: _formHandlers.plateFieldTouched,
                      focusNode: FocusNode(),
                      onChanged: (value) {
                        setState(() {
                          _formHandlers.plateFieldTouched = false;
                        });
                      },
                      validateField: (field) =>
                          _formHandlers.validateField(context, field),
                    ),
                    SizedBox(height: 20.h), // Espacio vertical.
                    const TipoDeVehiculo(), // Título del campo de tipo de vehículo.
                    VehicleTypeWidget(
                      selectedValue: _formHandlers.selectedVehicleType,
                      focusNode: FocusNode(),
                      onChanged: (value) {
                        setState(() {
                          _formHandlers.selectedVehicleType = value;
                          _formHandlers.vehicleTypeTouched = false;
                          _formHandlers.validateForm();
                        });
                      },
                      touched: _formHandlers.vehicleTypeTouched,
                      onValidate: _onValidate,
                      validateField: (field) =>
                          _formHandlers.validateField(context, field),
                    ),
                    SizedBox(height: 20.h), // Espacio vertical.
                    const ColorReporte(), // Título del campo de color.
                    ColorWidget(
                      selectedValue: _formHandlers.selectedColor,
                      focusNode: FocusNode(),
                      onChanged: (value) {
                        setState(() {
                          _formHandlers.selectedColor = value;
                          _formHandlers.colorTouched = false;
                          _formHandlers.validateForm();
                        });
                      },
                      touched: _formHandlers.colorTouched,
                      onValidate: _onValidate,
                      validateField: (field) =>
                          _formHandlers.validateField(context, field),
                    ),
                    SizedBox(height: 20.h), // Espacio vertical.
                    const Referencia(), // Título del campo de referencia.
                    AddressWidget(
                      controller: _formHandlers.addressController,
                      touched: _formHandlers.addressFieldTouched,
                      focusNode: FocusNode(),
                      onChanged: (value) {
                        setState(() {
                          _formHandlers.addressFieldTouched = false;
                        });
                      },
                      onValidate: _onValidate,
                    ),
                    SizedBox(height: 2.h), // Espacio vertical.
                    const DownTextVehiculoText(), // Texto adicional.
                    SizedBox(height: 20.h), // Espacio vertical.
                    StreamBuilder<Position>(
                      stream: _formHandlers.positionStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.hasData) {
                          return MapWidget(
                            height: 125.h,
                            lat: snapshot.data!.latitude,
                            lon: snapshot.data!.longitude,
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.h, vertical: 0.w),
                          );
                        } else {
                          return const Center(
                            child:
                                CircularProgressIndicator(), // Indicador de carga.
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16.h), // Espacio vertical.
                    SizedBox(
                      child: NextButton(
                        formHandlers: _formHandlers,
                        onValidate: _onValidate,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
