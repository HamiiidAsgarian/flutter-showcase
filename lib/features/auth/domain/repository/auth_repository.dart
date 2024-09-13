import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/domain/models/signup_res.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';

// ignore: one_member_abstracts
/// Abstract interface class for the [AuthRepository].
///
/// This class provides the authentication functionality which
/// includes signing up and logging in.
///
/// The [signUp] method is used to create a new user account.
/// The [login] method is used to login to an existing user account.
/// The [getLocalData] and [getLocalRememberMe] methods are used to
/// retrieve the locally stored user data and remember me value
/// respectively.
abstract class IAuthRepository {
  /// Signs up a user with the given [data] and [rememberMe] value.
  ///
  /// The [endpoint] is the endpoint of the request.
  /// The [data] is the user data to be sent in the request body.
  /// The [rememberMe] is a boolean value indicating whether the user
  /// wants to be remembered or not.
  ///
  /// Returns a [NetworkResponse] with the response data. If the response
  /// status code is not between 200 and 300, or if a [DioException] is
  /// thrown, returns a [NetworkResponse] with the error message and
  /// status code.
  Future<NetworkResponse<SignUpRes>> signUp({
    required String endpoint,
    required User data,
    required bool rememberMe,
  });

  /// Logs in a user with the given [data] and [rememberMe] value.
  ///
  /// The [endpoint] is the endpoint of the request.
  /// The [data] is the user data to be sent in the request body.
  /// The [rememberMe] is a boolean value indicating whether the user
  /// wants to be remembered or not.
  ///
  /// Returns a [NetworkResponse] with the response data. If the response
  /// status code is not between 200 and 300, or if a [DioException] is
  /// thrown, returns a [NetworkResponse] with the error message and
  /// status code.
  Future<NetworkResponse<Token>> login({
    required String endpoint,
    required User data,
    required bool rememberMe,
  });

  /// Retrieves the locally stored user data.
  ///
  /// Returns a [User] object with the locally stored user data.
  Future<User?> getLocalData();

  /// Retrieves the locally stored remember me value.
  ///
  /// Returns a boolean value indicating whether the user wants to be
  /// remembered or not.
  Future<bool> getLocalRememberMe();
}
