import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/logIn_User/user_login_api.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/Login_Bloc/_00_login_event.dart';
import 'package:frontend_android_ciudadano/Blocs/Login/Login_Bloc/_01_login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final result =
            await LoginSendData().signIn(event.username, event.password);
        if (result == true) {
          emit(LoginSuccess());
        } else if (result == 409) {
          emit(LoginFailure(
              'Ciudadano aun no esta activo, espere a ser aceptado'));
          _startErrorClearTimer();
        } else {
          emit(LoginFailure('Usuario o Contrasena Incorrecta'));
        }
      } catch (e) {
        emit(LoginFailure(e.toString()));
        _startErrorClearTimer();
      }
    });

    on<ClearError>((event, emit) {
      emit(LoginErrorCleared());
    });
  }

  void _startErrorClearTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      add(ClearError());
    });
  }
}
