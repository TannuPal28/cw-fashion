import 'package:cw_fashion/core/network/dio_client.dart';

import '../models/wishlist_model.dart';

class WishlistRemoveDatasources {
  final DioClient dioClient;
  WishlistRemoveDatasources(this.dioClient);


  Future<WishlistResponse> getWishlist() async {

    final response = await dioClient.get(
      "/users/wishlist",
    );

    return WishlistResponse.fromJson(response.data);
  }

  Future<void> removeWishlist(String productId) async {

    await dioClient.delete(
      "/users/wishlist/$productId",
    );
  }
}