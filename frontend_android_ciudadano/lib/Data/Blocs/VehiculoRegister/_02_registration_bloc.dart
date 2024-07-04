// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend_android_ciudadano/Data/Api/NuevoRegistro/_00.1_new_registro.dart';
// import 'package:frontend_android_ciudadano/Data/Blocs/VehiculoRegister/_00_registration_event.dart';
// import 'package:frontend_android_ciudadano/Data/Blocs/VehiculoRegister/_01_registration_state.dart';

// class VehicleRegistrationBloc
//     extends Bloc<VehicleRegistrationEvent, VehicleRegistrationState> {
//   final RegisterApi api;

//   VehicleRegistrationBloc(this.api) : super(VehicleRegistrationInitial());

//   Stream<VehicleRegistrationState> mapEventToState(
//       VehicleRegistrationEvent event) async* {
//     if (event is RegisterVehicle) {
//       yield VehicleRegistrationLoading();
//       try {
//         final success = await api.registerVehicle(
//           event.licensePlate,
//           event.vehicleType,
//           event.vehicleColor,
//           event.model,
//           event.year,
//           event.matricula,
//         );
//         if (success) {
//           yield VehicleRegistrationSuccess();
//         } else {
//           yield const VehicleRegistrationFailure(error: 'Registro fallido');
//         }
//       } catch (error) {
//         yield VehicleRegistrationFailure(error: error.toString());
//       }
//     }
//   }
// }
