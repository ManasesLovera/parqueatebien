import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Api/ConsultaDePlacas/_00_api_consulta_placa.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/VehiculoFetch/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/VehiculoFetch/_01_vehicle_state.dart';
import 'package:logger/logger.dart';

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
        _logger.e('Error fetching vehicle details: $e');
        emit(VehicleError(e.toString()));
      }
    });
  }
}
