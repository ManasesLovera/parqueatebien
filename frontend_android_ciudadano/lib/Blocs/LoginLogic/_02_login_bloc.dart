import 'package:frontend_android_ciudadano/Api/Login/_00_api.dart';
import 'package:frontend_android_ciudadano/Blocs/LoginLogic/_00_login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Blocs/LoginLogic/_01_login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final result =
            await LoginSendData().signIn(event.username, event.password);
        if (result) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Usuario O Contraseña Incorrecta'));
          _startErrorClearTimer();
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
    Future.delayed(const Duration(seconds: 5), () {
      add(ClearError());
    });
  }
}
