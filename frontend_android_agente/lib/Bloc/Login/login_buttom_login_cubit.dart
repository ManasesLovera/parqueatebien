import 'package:flutter_bloc/flutter_bloc.dart';

class ClassLoginCubit extends Cubit<bool> {
  // Constructor que inicializa el estado del Cubit en falso.
  ClassLoginCubit() : super(false);

  // Método para actualizar el estado del botón de login.
  void methodupdateButtonState(String id, String pass) {
    // Emite verdadero si ambos campos, id y pass, no están vacíos.
    emit(id.isNotEmpty && pass.isNotEmpty);
  }
}
