import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/domain/models/signup_res.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';

// ignore: one_member_abstracts
abstract interface class IAuthRepository {
  Future<NetworkResponse<SignUpRes>> signUp({
    required String endpoint,
    required User data,
  });

  //----

  Future<NetworkResponse<Token>> login({
    required String endpoint,
    required User data,
  });
  //----

  Future<User?> getLocalData();
  Future<bool> getLocalRememberMe();
}
