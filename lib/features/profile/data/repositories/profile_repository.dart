import '../datasources/profile_remote_datasource.dart';
import 'package:cw_fashion/features/profile/data/models/profile_response.dart';

class ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepository(this.remoteDatasource);

  Future<UserModel> updateProfile(
      Map<String, dynamic> body,
      ) {
    return remoteDatasource.updateProfile(body);
  }

  Future<void> updatePassword(Map<String, dynamic> body) async {
    await remoteDatasource.updatePassword(body);
  }
  Future<void> logout() async {
    await remoteDatasource.logout();
  }
}