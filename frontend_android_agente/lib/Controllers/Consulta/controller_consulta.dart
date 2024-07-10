import 'package:flutter/material.dart';
import 'package:frontend_android/APis/_01.1_consulta_.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';
import 'package:frontend_android/Pages/_02_3_Detalle_De_Consulta/_01_detalles_vehiculo_consult.dart';

class EnterPlateNumberController {
  final TextEditingController plateController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);
  bool isLoading = false;
  bool plateFieldTouched = false; // Agrega esta línea

  void dispose() {
    plateController.dispose();
  }

  void checkInput(String value) {
    isButtonEnabled.value = RegExp(r'^[A-Z][0-9]{6}$').hasMatch(value);
  }

  Future<void> searchVehicle(BuildContext context) async {
    isLoading = true;

    try {
      final vehicleData =
          await VehicleService().fetchVehicleDetails(plateController.text);
      final double lat = double.parse(vehicleData['lat'].toString());
      final double lon = double.parse(vehicleData['lon'].toString());

      if (!context.mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VehicleDetailsScreen(
            vehicleData: vehicleData,
            lat: lat,
            lon: lon,
          ),
        ),
      );
    } catch (e) {
      String errorMessage;
      if (e.toString().contains('Vehicle not found')) {
        errorMessage = 'Vehículo no encontrado';
      } else {
        errorMessage = 'vehículo no encontrado';
      }
      showUniversalSuccessErrorDialogConsulta(context, errorMessage, false);
    } finally {
      isLoading = false;
    }
  }
}
