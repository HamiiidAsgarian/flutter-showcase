class Token {
  Token({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

// ignore: constant_identifier_names
enum TokensType { access_token, refresh_token }
