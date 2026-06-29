import '../datasources/cart_remote_datasources.dart';
import '../models/cart_model.dart';

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


}