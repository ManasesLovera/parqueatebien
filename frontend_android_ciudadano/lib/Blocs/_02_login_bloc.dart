import 'package:frontend_android_ciudadano/Blocs/_00_login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/_01_login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await signIn(event.username, event.password);
        if (result) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Usuario O Contraseña Incorrecta'));
        }
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
