import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/AddNew_Vehicle/add_new_vehicle.dart';
import 'package:logger/logger.dart';
import 'new_vehicle_registration_event.dart';
import 'new_vehicle_registration_state.dart';

class NewVehicleRegistrationBloc
    extends Bloc<NewVehicleRegistrationEvent, NewVehicleRegistrationState> {
  final AddNewVehicleApi api;
  final Logger _logger = Logger();

  NewVehicleRegistrationBloc(this.api)
      : super(NewVehicleRegistrationInitial()) {
    on<RegisterNewVehicle>((event, emit) async {
      emit(NewVehicleRegistrationLoading());
      try {
        final success = await api.addVehicleNew(
          governmentId: event.governmentId,
          licensePlate: event.licensePlate,
          registrationDocument: event.matricula,
          model: event.model,
          year: event.year,
          color: event.vehicleColor,
        );
        if (success) {
          emit(NewVehicleRegistrationSuccess());
        } else {
          emit(const NewVehicleRegistrationFailure(
              error: 'Ya tiene un Vehiculo con esta placa'));
        }
      } catch (error) {
        _logger.e('Error adding vehicle: $error');
        emit(NewVehicleRegistrationFailure(error: error.toString()));
      }
    });
  }
}
