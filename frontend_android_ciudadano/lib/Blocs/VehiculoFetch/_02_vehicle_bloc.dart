import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/ConsultPlates/consult_plates_api.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoFetch/_01_vehicle_state.dart';
import 'package:logger/logger.dart';

// BLoC para manejar los eventos y estados relacionados con vehículos
class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final ConsultaPlaca placaconsult;
  final Logger _logger = Logger();

  VehicleBloc(this.placaconsult) : super(VehicleInitial()) {
    on<FetchLicencePlates>((event, emit) async {
      emit(VehicleLoading());
      try {
        final licencePlates =
            await placaconsult.fetchLicencePlates(event.governmentId);
        emit(VehicleLoaded(licencePlates));
      } catch (e) {
        _logger.e('Error fetching licence plates: $e');
        emit(VehicleError(e.toString()));
      }
    });

    on<SelectLicencePlate>((event, emit) {});

    on<FetchVehicleDetails>((event, emit) async {
      emit(VehicleLoading());
      try {
        _logger.i('Fetching details for plate: ${event.selectedPlate}');
        final vehicleDetails =
            await placaconsult.fetchVehicleDetails(event.selectedPlate);
        emit(VehicleDetailsLoaded(vehicleDetails));
      } catch (e) {
        if (e.toString().contains('Vehicle not found')) {
          emit(VehicleNotFound());
        } else {
          _logger.e('Error fetching vehicle details: $e');
          emit(VehicleError(e.toString()));
        }
      }
    });
  }
}
