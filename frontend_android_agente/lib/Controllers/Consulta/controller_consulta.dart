import 'package:flutter/material.dart';
import 'package:frontend_android/APis/_01.1_consulta_.dart';
import 'package:frontend_android/Handlers/Consulta/dialog_success_error_consulta.dart';
import 'package:frontend_android/Pages/_02_2_Consulta/_01_detalles_vehiculo_consult.dart';

class EnterPlateNumberController {
  final TextEditingController plateController =
      TextEditingController(); // Controlador para el campo de texto de la placa.
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(
      false); // Notificador para habilitar o deshabilitar el botón.
  bool isLoading = false; // Indica si se está cargando la búsqueda.
  bool plateFieldTouched =
      false; // Indica si el campo de la placa ha sido tocado.

  // Método para liberar los recursos del controlador.
  void dispose() {
    plateController.dispose();
  }

  // Método para verificar si la entrada es válida.
  void checkInput(String value) {
    isButtonEnabled.value = RegExp(r'^[A-Z][0-9]{6}$')
        .hasMatch(value); // Verifica que la placa tenga el formato correcto.
  }

  // Método para buscar un vehículo.
  Future<void> searchVehicle(BuildContext context) async {
    isLoading = true; // Indica que la búsqueda está en curso.

    try {
      // Intenta obtener los detalles del vehículo usando el servicio.
      final vehicleData =
          await VehicleService().fetchVehicleDetails(plateController.text);
      final double lat = double.parse(
          vehicleData['lat'].toString()); // Obtiene la latitud del vehículo.
      final double lon = double.parse(
          vehicleData['lon'].toString()); // Obtiene la longitud del vehículo.

      if (!context.mounted) return; // Verifica si el contexto está montado.

      // Navega a la pantalla de detalles del vehículo.
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
      // Manejo de errores en la búsqueda del vehículo.
      String errorMessage;
      if (e.toString().contains('Vehicle not found')) {
        errorMessage =
            'Incauto no encontrado'; // Mensaje de error si el vehículo no es encontrado.
      } else {
        errorMessage = 'Incauto no encontrado'; // Mensaje de error genérico.
      }
      showUniversalSuccessErrorDialogConsulta(
          context, errorMessage, false); // Muestra un diálogo de error.
    } finally {
      isLoading = false; // Indica que la búsqueda ha terminado.
    }
  }
}
