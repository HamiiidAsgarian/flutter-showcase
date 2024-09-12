import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/data/local/auth_local_data_source.dart';
import 'package:flutter_showcase/features/auth/data/models/signup_res_model.dart';
import 'package:flutter_showcase/features/auth/data/models/token_model.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';
import 'package:flutter_showcase/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:flutter_showcase/features/auth/domain/models/signup_res.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required bool rememberMe,
    required AuthRemoteDataSource authRemote,
    // required FlutterSecureStorage storageSecure,
    // required SharedPreferences storage,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authRemote = authRemote,
        // _storageSecure = storageSecure,
        // _storage = storage,
        _rememberMe = rememberMe,
        _authLocalDataSource = authLocalDataSource;

  final AuthRemoteDataSource _authRemote;
  // final FlutterSecureStorage _storageSecure;
  // final SharedPreferences _storage;
  final bool _rememberMe;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<NetworkResponse<SignUpRes>> signUp({
    required String endpoint,
    required User data,
  }) async {
    final convertedUserModel = data.toUserModel();

    final userModeledNetworkResponse =
        await _authRemote.signUp(endpoint: endpoint, data: convertedUserModel);

    // final storages = AuthLocalDataSource(
    //   secureStorage: _storageSecure,
    //   sharedPreferences: _storage,
    // );

    if (_rememberMe) {
      await _authLocalDataSource.saveUser(convertedUserModel);
      await _authLocalDataSource.saveRememberMe(value: true);
    } else {
      await _authLocalDataSource.saveRememberMe(value: false);
    }

    return NetworkResponse<SignUpRes>(
      data: userModeledNetworkResponse.data?.toSignUpRes(),
      error: userModeledNetworkResponse.error,
      isSuccess: userModeledNetworkResponse.isSuccess,
      statusCode: userModeledNetworkResponse.statusCode,
    );
  }

//----
  @override
  Future<NetworkResponse<Token>> login({
    required String endpoint,
    required User data,
  }) async {
    final convertedUserModel = data.toUserModel();

    final userModeledNetworkResponse =
        await _authRemote.login(endpoint: endpoint, data: convertedUserModel);

    if (userModeledNetworkResponse.isSuccess) {
      final tokenModel = userModeledNetworkResponse.data;

      // final storages = AuthLocalDataSource(
      //   secureStorage: _storageSecure,
      //   sharedPreferences: _storage,
      // );

      await _authLocalDataSource.saveToken(tokenModel!);

      if (_rememberMe) {
        await _authLocalDataSource.saveUser(convertedUserModel);
        await _authLocalDataSource.saveRememberMe(value: true);
      } else {
        await _authLocalDataSource.saveRememberMe(value: false);
      }
    }

    return NetworkResponse<Token>(
      //make [Token] out of [TokenModel]
      data: userModeledNetworkResponse.data?.toToken(),
      error: userModeledNetworkResponse.error,
      isSuccess: userModeledNetworkResponse.isSuccess,
      statusCode: userModeledNetworkResponse.statusCode,
    );
  }

  //----

  @override
  Future<User?> getLocalData() async {
    // final storages = AuthLocalDataSource(
    //   secureStorage: _storageSecure,
    //   sharedPreferences: _storage,
    // );

    final localUser = await _authLocalDataSource.getUser();

    if (localUser != null) {
      final convertedUserModel = localUser.toUser();
      return convertedUserModel;
    }
    return null;
  }

  //----
  @override
  Future<bool> getLocalRememberMe() async {
    final localUser = await _authLocalDataSource.getRememberMe();
    return localUser;
  }
}

//----
extension SignUpresModelToSignUpRes on SignUpResModel {
  SignUpRes toSignUpRes() => SignUpRes(success: success, message: message);
}

extension SignUpResToSignUpResModel on SignUpRes {
  SignUpResModel toSignUpResrModel() => SignUpResModel(
        success: success,
        message: message,
      );
}

//----
extension UserModelToUser on UserModel {
  User toUser() => User(id: id, email: email, password: password);
}

extension UserToUserModel on User {
  UserModel toUserModel() => UserModel(
        id: id,
        email: email,
        password: password,
      );
}

//----
extension TokenModelToToken on TokenModel {
  Token toToken() => Token(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}

extension TokenToTokenModel on Token {
  TokenModel toTokenModel() => TokenModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
