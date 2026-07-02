import 'dart:ffi';

import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:http/http.dart' as dio;

import '../../../../core/network/dio_client.dart';
import '../models/address_response_model.dart';
import '../models/cart_model.dart';
import '../models/order_response.dart';
import '../models/razorpay_order_model.dart';

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
    await dioClient.put("/cart/$cartItemId", data: {"quantity": quantity});
  }

  Future<void> removeCartItem(String cartItemId) async {
    await dioClient.delete("/cart/$cartItemId");
  }

  Future<AddressResponse> getAddresses() async {
    final response = await dioClient.get("/users/addresses");

    return AddressResponse.fromJson(response.data);
  }

  Future<void> addAddress(Map<String, dynamic> body) async {
    await dioClient.post("/users/addresses", data: body);
  }

  Future<OrderResponse> placeOrder(Map<String, dynamic> body) async {
    final response = await dioClient.post("/orders", data: body);

    return OrderResponse.fromJson(response.data);
  }

  Future<OrderResponse> getOrderDetail(String orderId) async {

    final response = await dioClient.get(
      "/orders/$orderId",
    );

    return OrderResponse.fromJson(response.data);
  }

  Future<RazorpayOrderModel> createRazorpayOrder(
      Map<String, dynamic> body) async {

    final response = await dioClient.post(
      "/orders/create-razorpay-order",
      data: body,
    );

    return RazorpayOrderModel.fromJson(response.data);
  }
}
