

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android/APis/_01.1_consulta_.dart';
import 'package:frontend_android/Bloc/Consulta/event_consulta.dart';
import 'package:frontend_android/Bloc/Consulta/state_consulta.dart';
import 'package:logger/logger.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleService _vehicleService;
  final Logger _logger = Logger(); // Instancia para el registro de logs.

  // Constructor que inicializa el servicio de vehículos y el estado inicial.
  VehicleBloc(this._vehicleService) : super(const VehicleInitial()) {
    on<FetchVehicleDetails>(
        _onFetchVehicleDetails); // Asocia el evento de obtener detalles del vehículo con su manejador.
    on<PlateTextChanged>(
        _onPlateTextChanged); // Asocia el evento de cambio de texto de la placa con su manejador.
  }

  // Manejador del evento FetchVehicleDetails.
  Future<void> _onFetchVehicleDetails(
      FetchVehicleDetails event, Emitter<VehicleState> emit) async {
    emit(const VehicleLoading()); // Emite el estado de carga.

    try {
      // Intenta obtener los detalles del vehículo usando el servicio.
      final vehicleData =
          await _vehicleService.fetchVehicleDetails(event.plate);
      final double lat =
          double.parse(vehicleData['lat'].toString()); // Obtiene la latitud.
      final double lon =
          double.parse(vehicleData['lon'].toString()); // Obtiene la longitud.
      emit(VehicleLoaded(
          vehicleData: vehicleData,
          lat: lat,
          lon: lon)); // Emite el estado de datos cargados.
    } catch (e) {
      _logger.e('Error: $e'); // Registra el error.
      emit(VehicleError(e.toString())); // Emite el estado de error.
    }
  }

  // Manejador del evento PlateTextChanged.
  void _onPlateTextChanged(PlateTextChanged event, Emitter<VehicleState> emit) {
    // No es necesario si se maneja el estado del botón en el propio widget.
  }
}
