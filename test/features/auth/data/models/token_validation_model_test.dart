import 'package:flutter_showcase/core/errors/exceptions.dart';
import 'package:flutter_showcase/features/auth/data/models/token_validation_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenValidationResponseModel', () {
    test('should throw JsonParseException when data is missing', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act and Assert
      expect(
        () => TokenValidationResponseModel.fromJson(json),
        throwsA(isA<JsonParseException>()),
      );
    });

    test('should return TokenValidationResponseModel when data is valid', () {
      // Arrange
      final json = <String, dynamic>{
        'success': true,
        'message': 'token is valid',
      };

      // Act
      final result = TokenValidationResponseModel.fromJson(json);

      // Assert
      expect(result, isA<TokenValidationResponseModel>());
      expect(result.isValid, true);
      expect(result.message, 'token is valid');
    });
  });
}
