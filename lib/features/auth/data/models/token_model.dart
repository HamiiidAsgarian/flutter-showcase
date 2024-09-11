import 'package:flutter_showcase/features/auth/domain/models/token.dart';

class TokenModel {
  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json[TokensType.access_token.name] as String,
      refreshToken: json[TokensType.refresh_token.name] as String,
    );
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
