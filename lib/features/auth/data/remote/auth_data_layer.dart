import 'package:dio/dio.dart';
import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';

class AuthRemote {
  const AuthRemote({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

  Future<NetworkResponse<UserModel>> getUser({required String endpoint}) async {
    final response = await NetworkService(
      dio: _dio,
      baseUrl: _baseUrl,
    ).get<UserModel>(
      endpoint: endpoint,
      fromJson: UserModel.fromJson,
    );

    return response;
  }
}
