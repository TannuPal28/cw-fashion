import 'package:cw_fashion/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cw_fashion/features/auth/data/models/login_response_model.dart';
import 'package:cw_fashion/features/auth/data/models/register_response_model.dart';

class AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepository(this.authRemoteDatasource);

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) {
    return authRemoteDatasource.login(email: email, password: password);
  }

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? referralCode,
  }) {
    return authRemoteDatasource.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      referralCode: referralCode,
    );
  }

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String otp,
  }) {
    return authRemoteDatasource.verifyEmail(email: email, otp: otp);
  }

  Future<Map<String, dynamic>> resendVerification({required String email}) {
    return authRemoteDatasource.resendOtp(email: email);
  }
}
