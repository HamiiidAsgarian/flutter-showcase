import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/data/local/auth_local_data_source.dart';
import 'package:flutter_showcase/features/auth/data/models/signup_res_model.dart';
import 'package:flutter_showcase/features/auth/data/models/token_model.dart';
import 'package:flutter_showcase/features/auth/data/models/token_validation_model.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';
import 'package:flutter_showcase/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:flutter_showcase/features/auth/domain/models/signup_res.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';

/// Authentication Repository implementation.
///
/// This class implements the [IAuthRepository] interface.
/// It provides the authentication functionality using the
/// [AuthRemoteDataSource] and [AuthLocalDataSource] classes.
class AuthRepository implements IAuthRepository {
  /// Constructor.
  ///
  /// It takes an [AuthRemoteDataSource] and an [AuthLocalDataSource]
  /// as parameters.
  AuthRepository({
    required AuthRemoteDataSource authRemote,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authRemote = authRemote,
        _authLocalDataSource = authLocalDataSource;

  final AuthRemoteDataSource _authRemote;
  final AuthLocalDataSource _authLocalDataSource;

  /// Signs up a user.
  ///
  /// It takes a [String] endpoint, a [User] data and a [bool] rememberMe
  ///  as parameters.
  /// It returns a [NetworkResponse] containing a [SignUpRes] object.
  @override
  Future<NetworkResponse<SignUpRes>> signUp({
    required String endpoint,
    required User data,
    required bool rememberMe,
  }) async {
    final convertedUserModel = data.toUserModel();

    final userModeledNetworkResponse =
        await _authRemote.signUp(endpoint: endpoint, data: convertedUserModel);

    if (rememberMe) {
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

  /// Logs in a user.
  ///
  /// It takes a [String] endpoint, a [User] data and a [bool] rememberMe
  ///  as parameters.
  /// It returns a [NetworkResponse] containing a [Token] object.
  @override
  Future<NetworkResponse<Token>> login({
    required String endpoint,
    required User data,
    required bool rememberMe,
  }) async {
    final convertedUserModel = data.toUserModel();

    final userModeledNetworkResponse =
        await _authRemote.login(endpoint: endpoint, data: convertedUserModel);

    if (userModeledNetworkResponse.isSuccess) {
      final tokenModel = userModeledNetworkResponse.data;

      await _authLocalDataSource.saveToken(tokenModel!);

      if (rememberMe) {
        await _authLocalDataSource.saveUser(convertedUserModel);
        await _authLocalDataSource.saveRememberMe(value: true);
      } else {
        await _authLocalDataSource.saveRememberMe(value: false);
      }
    }

    return NetworkResponse<Token>(
      data: userModeledNetworkResponse.data?.toToken(),
      error: userModeledNetworkResponse.error,
      isSuccess: userModeledNetworkResponse.isSuccess,
      statusCode: userModeledNetworkResponse.statusCode,
    );
  }

  /// Gets the local user data.
  ///
  /// It returns a [User] object or null if no local user data is found.
  @override
  Future<User?> getLocalData() async {
    final localUser = await _authLocalDataSource.getUser();

    if (localUser != null) {
      final convertedUserModel = localUser.toUser();
      return convertedUserModel;
    }
    return null;
  }

  /// Gets the local remember me value.
  ///
  /// It returns a [bool] value indicating whether the user wants to remember
  /// the login credentials or not.
  @override
  Future<bool> getLocalRememberMe() async {
    final localUser = await _authLocalDataSource.getRememberMe();
    return localUser;
  }

  // @override
  Future<TokenModel?> _getLocalTokens() async {
    final localToken = await _authLocalDataSource.getToken();

    return localToken;
  }

  @override
  Future<void> removeLocals() async {
    await _authLocalDataSource.removeLocals();
  }

  @override
  Future<NetworkResponse<TokenValidationResponseModel>?> authenticateToken({
    required String endpoint,
  }) async {
    final localToken = await _getLocalTokens();

    if (localToken == null) {
      return null;
    }

    final resToken = await _authRemote.validateTokens(
      endpoint: endpoint,
      data: localToken,
    );

    return resToken;
  }
}

//---------------------------------Adaptors-------------------------------------

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
