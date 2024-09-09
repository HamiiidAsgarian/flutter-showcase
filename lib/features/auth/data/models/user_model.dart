class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 000,
      email: json['email'] as String? ?? 'NA',
      password: json['password'] as String? ?? 'NA',
    );
  }
  final int id;
  final String email;
  final String password;
}
