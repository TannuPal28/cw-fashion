import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/profile/data/models/profile_response.dart';

class ProfileRemoteDatasource {
  final DioClient dioClient;

  ProfileRemoteDatasource(this.dioClient);

  Future<UserModel> updateProfile(Map<String, dynamic> body) async {
    final response = await dioClient.put(
      "/users/profile",
      data: body,
    );

    return UserModel.fromJson(response.data["user"]);
  }

  Future<void> updatePassword(Map<String, dynamic> body) async {
    await dioClient.put(
      "/auth/update-password",
      data: body,
    );
  }
  Future<void> logout() async {
    await dioClient.post("/auth/logout");
  }
}
