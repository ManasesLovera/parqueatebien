import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_02_Reporte/Controllers/form_controller.dart';
import 'package:frontend_android/Services/_02_Reporte/handlers/form_handlers.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_00_tittletext.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_01_subtitulo.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_03_placatext.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_04_plate_widget.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_05_tipovehiculotext.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_06_vehicle_type_widget.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_07_colortext.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_08_color_widget.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_08_referenciatext.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_09_reference_widget.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_10_referenciatextdown.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_12_nextbuttom.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_13_map.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FormController _formController;
  late FormHandlers _formHandlers;

  @override
  void initState() {
    super.initState();
    _formHandlers = FormHandlers(
      formKey: _formKey,
      plateController: TextEditingController(),
      addressController: TextEditingController(),
      showSnackBar: _showSnackBar,
      showDialog: _showDialog,
    );
    _formController = FormController(handlers: _formHandlers);
    _formController.init();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showDialog(String message) {
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

  void _onValidate() {
    setState(() {
      _formHandlers.plateFieldTouched = true;
      _formHandlers.vehicleTypeTouched = true;
      _formHandlers.colorTouched = true;
      _formHandlers.addressFieldTouched = true;
    });
    _formHandlers.validateForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_formHandlers.latitude != null &&
                      _formHandlers.longitude != null)
                    SizedBox(height: 20.h),
                  const TittleText(),
                  SizedBox(height: 10.h),
                  const DatosdelVehiculo(),
                  SizedBox(height: 30.h),
                  const NumeroPlaca(),
                  PlateWidget(
                    controller: _formHandlers.plateController,
                    touched: _formHandlers.plateFieldTouched,
                    focusNode: FocusNode(),
                    onChanged: (value) {
                      setState(() {
                        _formHandlers.plateFieldTouched = false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const TipodeVehiculo(),
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
                  ),
                  const SizedBox(height: 10),
                  const ColorText(),
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
                  ),
                  const SizedBox(height: 10),
                  const Referencia(),
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
                  const SizedBox(height: 1),
                  const DownTextVehiculoText(),
                  const MapWidget(),
                  SizedBox(height: 100.h),
                  NextButton(
                    formHandlers: _formHandlers,
                    onValidate: _onValidate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
