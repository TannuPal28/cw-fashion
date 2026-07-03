import 'package:cw_fashion/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository profileRepository;

  ProfileProvider(this.profileRepository);

  bool updateLoading = false;

  Future<bool> updateProfile({
    required String name,
    required String phone,
    required String gender,
    required DateTime dob,
  }) async {
    updateLoading = true;
    notifyListeners();

    try {
       await profileRepository.updateProfile({
        "name": name,
        "phone": phone,
        "gender": gender,
        "dob": DateFormat("yyyy-MM-dd").format(dob),
      });

      updateLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      updateLoading = false;
      notifyListeners();
      return false;
    }
  }

  bool passwordLoading = false;

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    passwordLoading = true;
    notifyListeners();

    try {
      await profileRepository.updatePassword({
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      });

      passwordLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      passwordLoading = false;
      notifyListeners();
      return false;
    }
  }
  bool logoutLoading = false;

  Future<bool> logout() async {
    logoutLoading = true;
    notifyListeners();

    try {
      await profileRepository.logout();
      logoutLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      logoutLoading = false;
      notifyListeners();
      return false;
    }
  }
}
