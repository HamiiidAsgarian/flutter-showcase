class SignUpResModel {
  SignUpResModel({
    required this.success,
    required this.message,
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) {
    return SignUpResModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
  final bool success;
  final String message;
}
