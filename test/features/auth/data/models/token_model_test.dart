import 'package:flutter_showcase/core/errors/exceptions.dart';
import 'package:flutter_showcase/features/auth/data/models/token_model.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test token model with valid json', () {
    // Arrange
    final json = <String, dynamic>{
      'access_token': 'access_token',
      'refresh_token': 'refresh_token',
    };

    // Act
    final tokenModel = TokenModel.fromJson(json);

    // Assert
    expect(tokenModel, isA<TokenModel>());
    expect(tokenModel.accessToken, 'access_token');
    expect(tokenModel.refreshToken, 'refresh_token');
  });

  test('test token model with invalid json', () {
    // Arrange
    final json = <String, dynamic>{};

    // Assert
    expect(
      () => TokenModel.fromJson(json),
      throwsA(isA<JsonParseException>()),
    );
  });

  test('test token model to json', () {
    // Arrange
    final tokenModel = TokenModel(
      accessToken: 'access_token',
      refreshToken: 'refresh_token',
    );

    // Act
    final json = tokenModel.toJson();

    // Assert
    expect(json, isA<Map<String, dynamic>>());
    expect(json[TokensType.access_token.name], 'access_token');
    expect(json[TokensType.refresh_token.name], 'refresh_token');
  });
}
