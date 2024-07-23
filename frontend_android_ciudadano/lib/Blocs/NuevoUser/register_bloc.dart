import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/Add_User/_00_user_register_api.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_state.dart';
import 'register_event.dart';

// Clase BLoC para manejar los eventos y estados del registro de usuario
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterApi registerApi;

  RegisterBloc(this.registerApi) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      // Emite un estado de carga al iniciar el registro
      emit(RegisterLoading());
      try {
        // Llama a la API para registrar al usuario
        final result = await registerApi.register(event.user);
        if (result == true) {
          // Emite un estado de éxito si el registro es exitoso
          emit(RegisterSuccess());
        } else if (result == 409) {
          // Emite un estado de fallo si el usuario ya existe
          emit(const RegisterFailure('Usuario ya existe.'));
        } else if (result == 400) {
          // Emite un estado de fallo si los datos son inválidos
          emit(const RegisterFailure('Datos Invalidos.'));
        } else {
          // Emite un estado de fallo para errores desconocidos
          emit(const RegisterFailure('Error Desconocido'));
        }
      } catch (e) {
        // Emite un estado de fallo si ocurre una excepción
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
