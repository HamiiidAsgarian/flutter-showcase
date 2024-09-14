import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.email, required this.password});
  final int? id;
  final String email;
  final String password;

  @override
  List<Object?> get props => [id, email, password];
}
