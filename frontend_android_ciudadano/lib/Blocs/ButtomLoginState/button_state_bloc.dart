import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ButtonStateEvent {}

class TextChanged extends ButtonStateEvent {
  final String iD;
  final String pass;

  TextChanged(this.iD, this.pass);
}

class ButtonState extends Equatable {
  final bool isEnabled;

  const ButtonState({required this.isEnabled});

  @override
  List<Object> get props => [isEnabled];
}

class ButtonStateBloc extends Bloc<ButtonStateEvent, ButtonState> {
  ButtonStateBloc() : super(const ButtonState(isEnabled: false)) {
    on<TextChanged>((event, emit) {
      if (event.iD.isNotEmpty && event.pass.isNotEmpty) {
        emit(const ButtonState(isEnabled: true));
      } else {
        emit(const ButtonState(isEnabled: false));
      }
    });
  }
}
