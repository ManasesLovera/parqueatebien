

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android/APis/_01.1_consulta_.dart';
import 'package:frontend_android/Bloc/Consulta/event_consulta.dart';
import 'package:frontend_android/Bloc/Consulta/state_consulta.dart';
import 'package:logger/logger.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleService _vehicleService;
  final Logger _logger = Logger();

  VehicleBloc(this._vehicleService) : super(const VehicleInitial()) {
    on<FetchVehicleDetails>(_onFetchVehicleDetails);
    on<PlateTextChanged>(_onPlateTextChanged);
  }

  Future<void> _onFetchVehicleDetails(
      FetchVehicleDetails event, Emitter<VehicleState> emit) async {
    emit(const VehicleLoading());

    try {
      final vehicleData =
          await _vehicleService.fetchVehicleDetails(event.plate);
      final double lat = double.parse(vehicleData['lat'].toString());
      final double lon = double.parse(vehicleData['lon'].toString());
      emit(VehicleLoaded(vehicleData: vehicleData, lat: lat, lon: lon));
    } catch (e) {
      _logger.e('Error: $e');
      emit(VehicleError(e.toString()));
    }
  }

  void _onPlateTextChanged(PlateTextChanged event, Emitter<VehicleState> emit) {
    // This is not necessary if you are handling the button state in the widget itself
  }
}
