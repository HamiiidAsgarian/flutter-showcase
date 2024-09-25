import 'package:flutter_showcase/core/errors/exceptions.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';

class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'access_token': final String accessToken,
          'refresh_token': final String refreshToken,
        }) {
      return TokenModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    } else {
      throw JsonParseException(
        body: json.toString(),
        error: 'access_token or refresh_token is missing',
      );
    }
  }
  Map<String, dynamic> toJson() {
    return {
      TokensType.access_token.name: accessToken,
      TokensType.refresh_token.name: refreshToken,
    };
  }

  final String accessToken;
  final String refreshToken;
}
