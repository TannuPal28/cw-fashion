import 'dart:ffi';

import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:http/http.dart' as dio;

import '../../../../core/network/dio_client.dart';
import '../models/cart_model.dart';

class CartRemoteDatasource {
  final DioClient dioClient;

  CartRemoteDatasource(this.dioClient);

  Future<CartResponse> getCart() async {
    final response = await dioClient.get(ApiConstants.cart);

    return CartResponse.fromJson(response.data);
  }

  Future<void> updateCart({
    required String cartItemId,
    required int quantity,
  }) async {
    await dioClient.put(
      "/cart/$cartItemId",
      data: {
        "quantity": quantity,
      },
    );
  }

  Future<void> removeCartItem(String cartItemId) async {
    await dioClient.delete("/cart/$cartItemId");
  }
}