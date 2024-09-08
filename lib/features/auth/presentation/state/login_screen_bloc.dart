import 'package:flutter_bloc/flutter_bloc.dart';

enum Stage { init, loading, success, error }

//----events
abstract class LoginScreeEvent {}

class ValidateForm extends LoginScreeEvent {}

class SavePassword extends LoginScreeEvent {
  SavePassword(this.password);
  final String password;
}

class SaveEmail extends LoginScreeEvent {
  SaveEmail(this.email);
  final String email;
}

class ChangeRememberMe extends LoginScreeEvent {
  ChangeRememberMe({required this.checkboxValue});
  final bool checkboxValue;
}

//----state
class LoginScreeState {
  LoginScreeState.init() : stage = Stage.init;

  const LoginScreeState._({required this.stage});

  final Stage stage;

  LoginScreeState copyWith({
    Stage? stage,
  }) =>
      LoginScreeState._(
        stage: stage ?? this.stage,
      );
}

//----bloc
class LoginScreeBloc extends Bloc<LoginScreeEvent, LoginScreeState> {
  LoginScreeBloc() : super(LoginScreeState.init()) {
    on<ValidateForm>(_onValidateForm);
    on<SaveEmail>(_onSaveEmail);
    on<SavePassword>(_onSavePassword);
    on<ChangeRememberMe>(_onChangeRememberMe);
  }
  String? savedEmail;
  String? savedPass;
  bool? isRemembered;

  void _onSaveEmail(SaveEmail event, Emitter<LoginScreeState> emit) {
    savedEmail = event.email;
  }

  void _onSavePassword(SavePassword event, Emitter<LoginScreeState> emit) {
    savedPass = event.password;
  }

  void _onChangeRememberMe(
    ChangeRememberMe event,
    Emitter<LoginScreeState> emit,
  ) {
    isRemembered = event.checkboxValue;
  }

  void _onValidateForm(ValidateForm event, Emitter<LoginScreeState> emit) {
    // emit(state.copyWith(stage: Stage.loading));
    print('$savedEmail  $savedPass  $isRemembered');
  }
}
