import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/config/endpoints.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';

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

class GetUserDataFromLocal extends LoginScreeEvent {
  GetUserDataFromLocal();
}

//----state
class LoginScreeState {
  LoginScreeState.init()
      : stage = Stage.init,
        user = null,
        rememberMe = false;

  const LoginScreeState._({
    required this.stage,
    this.user,
    this.rememberMe = false,
  });

  final Stage stage;
  final User? user;
  final bool rememberMe;

  LoginScreeState copyWith({
    Stage? stage,
    User? user,
    bool? rememberMe,
  }) =>
      LoginScreeState._(
        stage: stage ?? this.stage,
        user: user ?? this.user,
        rememberMe: rememberMe ?? this.rememberMe,
      );
}

//----bloc
class LoginScreeBloc extends Bloc<LoginScreeEvent, LoginScreeState> {
  LoginScreeBloc({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginScreeState.init()) {
    on<ValidateForm>(_onValidateForm);
    on<SaveEmail>(_onSaveEmail);
    on<SavePassword>(_onSavePassword);
    on<ChangeRememberMe>(_onChangeRememberMe);
    on<GetUserDataFromLocal>(_onGetUserDataFromLocal);
  }
  final IAuthRepository _authRepository;
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

  Future<void> _onValidateForm(
    ValidateForm event,
    Emitter<LoginScreeState> emit,
  ) async {
    emit(state.copyWith(stage: Stage.loading));

    final user = User(id: 0, email: savedEmail!, password: savedPass!);

    final userNetweorkResponse = await _authRepository.login(
      endpoint: Endpoints.login,
      data: user,
      rememberMe: isRemembered ?? false,
    );

    if (userNetweorkResponse.isSuccess) {
      emit(state.copyWith(stage: Stage.success));
    } else {
      emit(state.copyWith(stage: Stage.error));
    }
  }

  //----
  Future<void> _onGetUserDataFromLocal(
    GetUserDataFromLocal event,
    Emitter<LoginScreeState> emit,
  ) async {
    final localUserRes = await _authRepository.getLocalData();
    final localrememberMeRes = await _authRepository.getLocalRememberMe();

    emit(state.copyWith(user: localUserRes, rememberMe: localrememberMeRes));
  }
}
