import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del botón (habilitado/deshabilitado)
class ButtonStateCubit extends Cubit<bool> {
  ButtonStateCubit() : super(false);

  // Método para actualizar el estado del botón
  void updateButtonState(bool isEnabled) => emit(isEnabled);
}
