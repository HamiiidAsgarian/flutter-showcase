import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A service to make network requests.
class NetworkService {
  /// Creates a new instance of [NetworkService].
  ///
  /// [dio] is the Dio instance used to make requests.
  /// [baseUrl] is the base URL of the API.
  NetworkService({required this.dio, required this.baseUrl});

  /// The Dio instance used to make requests.
  final Dio dio;

  /// The base URL of the API.
  final String baseUrl;

  /// Makes a GET request to the given endpoint.
  ///
  /// [endpoint] is the endpoint of the request.
  /// [fromJson] is a function that converts the response data to the
  ///  desired type [T].
  ///
  /// Returns a [NetworkResponse] with the response data. If the response
  ///  status code
  /// is not between 200 and 300, or if a [DioException] is thrown, returns a
  /// [NetworkResponse] with the error message and status code.
  Future<NetworkResponse<T>> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response =
          await dio.get<Map<String, dynamic>>('$baseUrl/$endpoint');

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data!;
        return NetworkResponse<T>.success(
          statusCode: response.statusCode,
          data: fromJson(data),
        );
      } else {
        return NetworkResponse.failure(
          error: response.statusMessage ?? 'Unknown error',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return NetworkResponse.failure(error: e.message);
    }
  }

  //---------------------------------------------------------------------------
  /// Makes a POST request to the given endpoint.
  ///
  /// [endpoint] is the endpoint of the request.
  /// [data] is the data sent in the request body.
  /// [fromJson] is a function that converts the response data to
  ///  the desired type [T].
  ///
  /// Returns a [NetworkResponse] with the response data. If the response
  ///  status code
  /// is not between 200 and 300, or if a [DioException] is thrown, returns a
  /// [NetworkResponse] with the error message and status code.
  Future<NetworkResponse<T>> post<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/$endpoint',
        data: data,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data!;
        return NetworkResponse<T>.success(
          statusCode: response.statusCode,
          data: fromJson(data),
        );
      } else {
        return NetworkResponse.failure(
          error: response.statusMessage ?? 'Unknown error',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return NetworkResponse.failure(error: e.message);
    }
  }
}

/// A response from a network request.
@immutable
class NetworkResponse<T> {
  const NetworkResponse({
    required this.isSuccess,
    this.error,
    this.data,
    this.statusCode,
  });

  /// Creates a response with an error message and status code.
  const NetworkResponse.failure({
    required this.error,
    this.data,
    this.statusCode,
    this.isSuccess = false,
  });

  /// Creates a response with the response data.
  const NetworkResponse.success({
    required this.statusCode,
    required this.data,
    this.error,
    this.isSuccess = true,
  });

  NetworkResponse<T> copyWith({
    bool? isSuccess,
    int? statusCode,
    T? data,
    String? error,
  }) =>
      NetworkResponse<T>(
        error: error ?? this.error,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        isSuccess: isSuccess ?? this.isSuccess,
      );

  /// The result is a success.
  final bool isSuccess;

  /// The status code of the response.
  final int? statusCode;

  /// The response data.
  final T? data;

  /// The error message of the response.
  final String? error;
}
