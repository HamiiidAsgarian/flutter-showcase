import 'package:flutter_showcase/core/errors/exceptions.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('should throw JsonParseException when data is missing', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act and Assert
      expect(
        () => UserModel.fromJson(json),
        throwsA(isA<JsonParseException>()),
      );
    });

    test('should return UserModel when data is valid', () {
      // Arrange
      final json = <String, dynamic>{
        'id': 1,
        'email': 'email',
        'password': 'password',
      };

      // Act
      final result = UserModel.fromJson(json);

      // Assert
      expect(result, isA<UserModel>());
      expect(result.id, 1);
      expect(result.email, 'email');
      expect(result.password, 'password');
    });
  });
}
