import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/Add_User/_01_add_vehicle_with_user.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoRegister/_00_registration_event.dart';
import 'package:frontend_android_ciudadano/Blocs/VehiculoRegister/_01_registration_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

// BLoC para manejar los eventos y estados relacionados con el registro de vehículos
class VehicleRegistrationBloc
    extends Bloc<VehicleRegistrationEvent, VehicleRegistrationState> {
  final AddVehicleApi api;

  VehicleRegistrationBloc(this.api) : super(VehicleRegistrationInitial()) {
    on<RegisterVehicle>((event, emit) async {
      emit(VehicleRegistrationLoading());
      try {
        final success = await api.addVehicle(
          governmentId: event.governmentId,
          licensePlate: event.licensePlate,
          registrationDocument: event.matricula,
          model: event.model,
          year: event.year,
          color: event.vehicleColor,
        );
        if (success) {
          emit(VehicleRegistrationSuccess());
        } else {
          emit(const VehicleRegistrationFailure(
              error: 'Ya tiene un Vehiculo con esta placa'));
        }
      } catch (error) {
        emit(VehicleRegistrationFailure(error: error.toString()));
      }
    });

    on<FetchGovernmentId>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final governmentId = prefs.getString('governmentId');
      if (governmentId != null) {
        add(RegisterVehicle(
          governmentId: governmentId,
          licensePlate: event.licensePlate,
          vehicleType: event.vehicleType,
          vehicleColor: event.vehicleColor,
          model: event.model,
          year: event.year,
          matricula: event.matricula,
        ));
      } else {
        emit(const VehicleRegistrationFailure(
            error: 'No se encontró el ID del usuario'));
      }
    });
  }
}
