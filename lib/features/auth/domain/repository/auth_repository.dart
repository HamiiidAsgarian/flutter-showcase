import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';

// ignore: one_member_abstracts
abstract interface class AuthRepository {
  Future<NetworkResponse<User>> getUser({required String endpoint});
}
