import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_showcase/features/auth/data/local/auth_local_data_source.dart';
import 'package:flutter_showcase/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:flutter_showcase/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  LoginScreeBloc() : super(LoginScreeState.init()) {
    on<ValidateForm>(_onValidateForm);
    on<SaveEmail>(_onSaveEmail);
    on<SavePassword>(_onSavePassword);
    on<ChangeRememberMe>(_onChangeRememberMe);
    on<GetUserDataFromLocal>(_onGetUserDataFromLocal);
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

  Future<void> _onValidateForm(
    ValidateForm event,
    Emitter<LoginScreeState> emit,
  ) async {
    final user = User(id: 0, email: savedEmail!, password: savedPass!);

    final remoteDataSource =
        AuthRemoteDataSource(dio: Dio(), baseUrl: 'http://localhost:3000');

    final localDataSource = AuthLocalDataSource(
      secureStorage: const FlutterSecureStorage(),
      sharedPreferences: await SharedPreferences.getInstance(),
    );

    final userNetweorkResponse = await AuthRepository(
      authLocalDataSource: localDataSource,
      authRemote: remoteDataSource,
      rememberMe: isRemembered ?? false,
    ).login(endpoint: 'api/v1/login', data: user);

//TODO: also save isRemembered inside the local
    print(userNetweorkResponse);
  }

  //----
  Future<void> _onGetUserDataFromLocal(
    GetUserDataFromLocal event,
    Emitter<LoginScreeState> emit,
  ) async {
    //TODO make sure to get the dependencies(except isRemmberd from outside)
    final remoteDataSource =
        AuthRemoteDataSource(dio: Dio(), baseUrl: 'http://localhost:3000');

    final localDataSource = AuthLocalDataSource(
      secureStorage: const FlutterSecureStorage(),
      sharedPreferences: await SharedPreferences.getInstance(),
    );

    final localUser = AuthRepository(
      authRemote: remoteDataSource,
      authLocalDataSource: localDataSource,
      rememberMe: false,
    );
    final localUserRes = await localUser.getLocalData();
    final localrememberMeRes = await localUser.getLocalRememberMe();

    emit(state.copyWith(user: localUserRes, rememberMe: localrememberMeRes));
  }
}
