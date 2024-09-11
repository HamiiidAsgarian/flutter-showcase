class UserModel {
  const UserModel({
    required this.email,
    required this.password,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 000,
      email: json['email'] as String? ?? 'NA',
      password: json['password'] as String? ?? 'NA',
    );
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
