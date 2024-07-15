import 'package:flutter_bloc/flutter_bloc.dart';

class ClassLoginCubit extends Cubit<bool> {
  ClassLoginCubit() : super(false);

  void methodupdateButtonState(String id, String pass) {
    emit(id.isNotEmpty && pass.isNotEmpty);
  }
}
