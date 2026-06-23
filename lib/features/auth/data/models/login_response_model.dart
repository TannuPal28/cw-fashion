class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final String refreshToken;
  final UserModel user;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json["success"],
      message: json["message"],
      token: json["token"],
      refreshToken: json["refreshToken"],
      user: UserModel.fromJson(json["user"]),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isEmailVerified;
  final String phone;
  final String referralCode;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isEmailVerified,
    required this.phone,
    required this.referralCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      isEmailVerified: json["isEmailVerified"],
      phone: json["phone"] ?? "",
      referralCode: json["referralCode"] ?? "",
    );
  }
}