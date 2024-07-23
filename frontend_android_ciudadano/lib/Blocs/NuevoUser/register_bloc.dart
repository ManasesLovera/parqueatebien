import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/Add_User/user_register_api.dart';
import 'package:frontend_android_ciudadano/Blocs/NuevoUser/register_state.dart';
import 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterApi registerApi;

  RegisterBloc(this.registerApi) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await registerApi.register(event.user);
        if (result == true) {
          emit(RegisterSuccess());
        } else if (result == 409) {
          emit(const RegisterFailure('Usuario ya existe.'));
        } else if (result == 400) {
          emit(const RegisterFailure('Datos Invalidos.'));
        } else {
          emit(const RegisterFailure('Error Desconocido'));
        }
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
