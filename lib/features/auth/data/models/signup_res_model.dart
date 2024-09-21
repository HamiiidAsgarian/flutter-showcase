import 'package:flutter_showcase/core/errors/exceptions.dart';

class SignUpResModel {
  SignUpResModel({
    required this.success,
    required this.message,
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {'success': final bool success, 'message': final String message}) {
      return SignUpResModel(
        success: success,
        message: message,
      );
    } else {
      throw JsonParseException(
        body: json.toString(),
        error: 'data is missing',
      );
    }
  }
  final bool success;
  final String message;
}
