import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/AddNew_Vehicle/add_new_vehicle.dart';
import 'package:logger/logger.dart';
import 'new_vehicle_registration_event.dart';
import 'new_vehicle_registration_state.dart';

// BLoC para manejar los eventos y estados del registro de un nuevo vehículo
class NewVehicleRegistrationBloc
    extends Bloc<NewVehicleRegistrationEvent, NewVehicleRegistrationState> {
  final AddNewVehicleApi api;
  final Logger _logger = Logger();

  NewVehicleRegistrationBloc(this.api)
      : super(NewVehicleRegistrationInitial()) {
    on<RegisterNewVehicle>((event, emit) async {
      // Emite un estado de carga al iniciar el registro de vehículo
      emit(NewVehicleRegistrationLoading());
      try {
        // Llama a la API para registrar el nuevo vehículo
        final success = await api.addVehicleNew(
          governmentId: event.governmentId,
          licensePlate: event.licensePlate,
          registrationDocument: event.matricula,
          model: event.model,
          year: event.year,
          color: event.vehicleColor,
        );
        if (success) {
          // Emite un estado de éxito si el registro es exitoso
          emit(NewVehicleRegistrationSuccess());
        } else {
          // Emite un estado de fallo si ya existe un vehículo con la misma placa
          emit(const NewVehicleRegistrationFailure(
              error: 'Ya tiene un Vehiculo con esta placa'));
        }
      } catch (error) {
        // Manejo de excepciones y emite un estado de fallo
        _logger.e('Error adding vehicle: $error');
        emit(NewVehicleRegistrationFailure(error: error.toString()));
      }
    });
  }
}
