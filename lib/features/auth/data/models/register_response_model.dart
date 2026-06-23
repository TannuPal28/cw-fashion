class RegisterResponseModel {
  final bool success;
  final String message;
  final String email;

  RegisterResponseModel({
    required this.success,
    required this.message,
    required this.email,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      email: json["email"] ?? "",
    );
  }
}