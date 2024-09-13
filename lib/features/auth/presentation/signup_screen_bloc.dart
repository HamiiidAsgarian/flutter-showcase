import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/config/endpoints.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';

enum Stage { init, loading, success, error }

//----events
abstract class SignUpScreeEvent {}

class ValidateForm extends SignUpScreeEvent {}

class SavePassword2 extends SignUpScreeEvent {
  SavePassword2(this.password);
  final String password;
}

class SaveEmail extends SignUpScreeEvent {
  SaveEmail(this.email);
  final String email;
}

class ChangeRememberMe extends SignUpScreeEvent {
  ChangeRememberMe({required this.checkboxValue});
  final bool checkboxValue;
}

class GetUserDataFromLocal extends SignUpScreeEvent {
  GetUserDataFromLocal();
}

//----state
class SignUpScreeState {
  SignUpScreeState.init()
      : stage = Stage.init,
        user = null,
        rememberMe = false;

  const SignUpScreeState._({
    required this.stage,
    this.user,
    this.rememberMe = false,
  });

  final Stage stage;
  final User? user;
  final bool rememberMe;

  SignUpScreeState copyWith({
    Stage? stage,
    User? user,
    bool? rememberMe,
  }) =>
      SignUpScreeState._(
        stage: stage ?? this.stage,
        user: user ?? this.user,
        rememberMe: rememberMe ?? this.rememberMe,
      );
}

//----bloc
class SignUpScreeBloc extends Bloc<SignUpScreeEvent, SignUpScreeState> {
  SignUpScreeBloc({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpScreeState.init()) {
    on<ValidateForm>(_onValidateForm);
    on<SaveEmail>(_onSaveEmail);
    on<SavePassword2>(_onSavePassword);
    on<ChangeRememberMe>(_onChangeRememberMe);
    on<GetUserDataFromLocal>(_onGetUserDataFromLocal);
  }

  final IAuthRepository _authRepository;
  String? savedEmail;
  String? savedPass;
  bool? isRemembered;

  void _onSaveEmail(SaveEmail event, Emitter<SignUpScreeState> emit) {
    savedEmail = event.email;
  }

  void _onSavePassword(SavePassword2 event, Emitter<SignUpScreeState> emit) {
    savedPass = event.password;
  }

  void _onChangeRememberMe(
    ChangeRememberMe event,
    Emitter<SignUpScreeState> emit,
  ) {
    isRemembered = event.checkboxValue;
  }

  Future<void> _onValidateForm(
    ValidateForm event,
    Emitter<SignUpScreeState> emit,
  ) async {
    final user = User(id: 0, email: savedEmail!, password: savedPass!);

    final userNetweorkResponse = await _authRepository.signUp(
      endpoint: Endpoints.signup,
      data: user,
      rememberMe: isRemembered ?? false,
    );

    if (userNetweorkResponse.isSuccess) {
      emit(state.copyWith(stage: Stage.success));
    }
  }

  // ----
  Future<void> _onGetUserDataFromLocal(
    GetUserDataFromLocal event,
    Emitter<SignUpScreeState> emit,
  ) async {
    final localUser = _authRepository;

    final localrememberMeRes = await localUser.getLocalRememberMe();

    emit(state.copyWith(rememberMe: localrememberMeRes));
  }
}
