import 'package:flutter_showcase/core/errors/exceptions.dart';

class UserModel {
  const UserModel({
    required this.email,
    required this.password,
    this.id,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': final int id,
          'email': final String email,
          'password': final String password
        }) {
      return UserModel(
        id: id,
        email: email,
        password: password,
      );
    } else {
      throw JsonParseException(
        body: json.toString(),
        error: 'id, email or password is missing',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  final int? id;
  final String email;
  final String password;
}
