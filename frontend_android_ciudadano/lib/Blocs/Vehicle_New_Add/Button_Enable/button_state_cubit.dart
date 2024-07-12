import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<bool> {
  ButtonStateCubit() : super(false);

  void updateButtonState(bool isEnabled) => emit(isEnabled);
}
