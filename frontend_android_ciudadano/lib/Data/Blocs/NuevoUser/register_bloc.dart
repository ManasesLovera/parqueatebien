import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Data/Api/NuevoRegistro/_00.1_api_nuevo_registro.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/NuevoUser/register_state.dart';

import 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterApi registerApi;

  RegisterBloc(this.registerApi) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await registerApi.register(event.user);
        if (result) {
          emit(RegisterSuccess());
        } else {
          emit(const RegisterFailure('Registro fallido. Inténtalo de nuevo.'));
        }
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
