import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/auth/data/models/login_response_model.dart';
import 'package:cw_fashion/features/auth/data/models/register_response_model.dart';

class AuthRemoteDatasource {
  final DioClient dioClient;

  AuthRemoteDatasource(this.dioClient);

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.post(
      ApiConstants.login,
      data: {"email": email, "password": password},
    );
    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? referralCode,
  }) async {
    final response = await dioClient.post(
      ApiConstants.register,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "referralCode": referralCode ?? "",
      },
    );
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    final response= await dioClient.post(ApiConstants.verifyEmail,data: {
      "email":email,
      "otp":otp
    });
    return response.data;
  }

  Future<Map<String,dynamic>> resendOtp({
    required String email
}) async{
    final response= await dioClient.post(ApiConstants.resendVerification,data: {
      "email":email
    });
    return response.data;
  }
}
