import 'package:cw_fashion/features/cart/data/models/address_response_model.dart';

import '../datasources/cart_remote_datasources.dart';
import '../models/cart_model.dart';
import '../models/order_response.dart';
import '../models/razorpay_order_model.dart';

class CartRepository {
  final CartRemoteDatasource datasource;

  CartRepository(this.datasource);

  Future<CartResponse> getCart() {
    return datasource.getCart();
  }
  Future<void> updateCart({
    required String cartItemId,
    required int quantity,
  }) {
    return datasource.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
  }

  Future<void> removeCartItem(String cartItemId) {
    return datasource.removeCartItem(cartItemId);
  }

  Future<AddressResponse> getAddress(){
    return datasource.getAddresses();
  }
  Future<void> addAddress(Map<String, dynamic> body) {
    return datasource.addAddress(body);
  }

  Future<OrderResponse> placeOrder(
      Map<String, dynamic> body,
      ) {
    return datasource.placeOrder(body);
  }

  Future<OrderResponse> getOrderDetail(String orderId) {
    return datasource.getOrderDetail(orderId);
  }

  Future<RazorpayOrderModel> createRazorpayOrder(
      Map<String, dynamic> body) {
    return datasource.createRazorpayOrder(body);
  }

}