import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);

  void updateButtonState(String id, String pass) {
    emit(id.isNotEmpty && pass.isNotEmpty);
  }
}
