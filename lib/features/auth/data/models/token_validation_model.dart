import 'package:flutter_showcase/core/errors/exceptions.dart';

class TokenValidationResponseModel {
  TokenValidationResponseModel({
    required this.isValid,
    this.message,
  });

  factory TokenValidationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'success': final bool isValid,
          'message': final String? message
        }) {
      return TokenValidationResponseModel(
        isValid: isValid,
        message: message,
      );
    } else {
      throw JsonParseException(
        body: json.toString(),
        error: 'success or message is missing',
      );
    }
  }
  final bool isValid;
  final String? message;
}
