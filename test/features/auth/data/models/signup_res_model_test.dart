import 'package:flutter_showcase/core/errors/exceptions.dart';
import 'package:flutter_showcase/features/auth/data/models/signup_res_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUpResModel', () {
    test('should throw JsonParseException when data is missing', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act and Assert
      expect(
        () => SignUpResModel.fromJson(json),
        throwsA(isA<JsonParseException>()),
      );
    });

    test('should return SignUpResModel when data is valid', () {
      // Arrange
      final json = <String, dynamic>{
        'success': true,
        'message': 'sign up success',
      };

      // Act
      final result = SignUpResModel.fromJson(json);

      // Assert
      expect(result, isA<SignUpResModel>());
      expect(result.success, true);
      expect(result.message, 'sign up success');
    });
  });
}
