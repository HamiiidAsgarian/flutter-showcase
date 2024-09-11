import 'package:dio/dio.dart';
import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/data/models/token_model.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<NetworkResponse<UserModel>> getUser({
    required String endpoint,
    required UserModel data,
  });

  Future<NetworkResponse<TokenModel>> login({
    required String endpoint,
    required UserModel data,
  });
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  const AuthRemoteDataSource({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

  @override
  Future<NetworkResponse<UserModel>> getUser({
    required String endpoint,
    required UserModel data,
  }) async {
    final response = await NetworkService(
      dio: _dio,
      baseUrl: _baseUrl,
    ).post<UserModel>(
      data: data.toJson(),
      endpoint: endpoint,
      fromJson: UserModel.fromJson,
    );

    return response;
  }

  @override
  Future<NetworkResponse<TokenModel>> login({
    required String endpoint,
    required UserModel data,
  }) async {
    final response = await NetworkService(
      dio: _dio,
      baseUrl: _baseUrl,
    ).post<TokenModel>(
      data: data.toJson(),
      endpoint: endpoint,
      fromJson: TokenModel.fromJson,
    );

    return response;
  }
}
