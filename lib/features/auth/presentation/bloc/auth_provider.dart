import 'package:cw_fashion/core/utils/auth_manager.dart';
import 'package:cw_fashion/features/auth/data/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider(this.repository);

  bool isLoading = false;
  bool isVerifying = false;
  bool isResending = false;
  String? errorMessage;

  Future<bool> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.login(email: email, password: password);
      await AuthManager.saveToken(response.token);
      await AuthManager.saveUserData(
        name: response.user.name,
        email: response.user.email,
      );

      debugPrint(response.token);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? referralCode,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        referralCode: referralCode,
      );

      isLoading = false;
      notifyListeners();

      return response.success;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> verifyEmail({required String email, required String otp}) async {
    isVerifying = true;
    notifyListeners();

    try {
      final response = await repository.verifyEmail(email: email, otp: otp);

      await AuthManager.saveToken(response["token"]);

      isVerifying = false;
      notifyListeners();

      return true;
    } catch (e) {
      errorMessage = e.toString();
      isVerifying = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resendVerification({required String email}) async {
    isResending = true;
    notifyListeners();

    try {
      await repository.resendVerification(email: email);

      isResending = false;
      notifyListeners();

      return true;
    } catch (e) {
      errorMessage = e.toString();
      isResending = false;
      notifyListeners();
      return false;
    }
  }
}
