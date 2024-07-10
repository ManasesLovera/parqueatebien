import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Controllers/Reporte/form_controller.dart';
import 'package:frontend_android/Handlers/Reportes/report_handler.dart';
import 'package:frontend_android/Pages/_01_Welcome/welcome.dart';
import 'package:frontend_android/Widgets/Map_Global/map_global.dart';
import 'package:frontend_android/Widgets/Reportes/report_widgets.dart';
import 'package:frontend_android/routes/app_routes.dart.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FormControllerReport _formController;
  late FormHandlersReport _formHandlers;

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
      _formController.init(context); // Pass the context here
    });
  }

  void submitReport() {
    Navigator.pushNamed(
      context,
      AppRoutes.foto,
      arguments: {
        'plateNumber': 'ABC123',
        'vehicleType': 'Car',
        'color': 'Red',
        'address': '123 Main St',
        'latitude': '37.7749',
        'longitude': '-122.4194',
      },
    );
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

  void _onValidate() {
    setState(() {
      _formHandlers.plateFieldTouched = true;
      _formHandlers.vehicleTypeTouched = true;
      _formHandlers.colorTouched = true;
      _formHandlers.addressFieldTouched = true;
    });
    _formHandlers.validateOnSubmit(context); // Pass the context here
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
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
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
                    const TitleText(),
                    SizedBox(height: 10.h),
                    const DatosDelVehiculo(),
                    SizedBox(height: 30.h),
                    const NumeroPlaca(),
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
                    SizedBox(height: 20.h),
                    const TipoDeVehiculo(),
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
                    SizedBox(height: 20.h),
                    const ColorReporte(),
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
                    SizedBox(height: 20.h),
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
                    SizedBox(height: 2.h),
                    const DownTextVehiculoText(),
                    SizedBox(height: 20.h),
                    MapWidget(
                      height: 125.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.h, vertical: 0.w),
                    ),
                    SizedBox(height: 16.h),
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
