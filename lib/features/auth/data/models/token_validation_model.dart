class TokenValidationResponseModel {
  TokenValidationResponseModel({
    required this.isValid,
    this.message,
  });

  factory TokenValidationResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenValidationResponseModel(
      isValid: (json['success'] ?? false) as bool,
      message: json['message'] as String?,
    );
  }
  final bool isValid;
  final String? message;
}
