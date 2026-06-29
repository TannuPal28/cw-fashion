import 'package:flutter/material.dart';

import '../../data/models/cart_model.dart';
import '../../data/repository/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository repository;

  CartProvider(this.repository);

  bool isLoading = false;

  List<CartItem> items = [];
  ShippingInfo? shippingInfo;

  Future<void> getCart({bool showLoader = true}) async {
    try {
      if (showLoader) {
        isLoading = true;
        notifyListeners();
      }

      final response = await repository.getCart();

      items = response.cart.items;
      shippingInfo = response.cart.shippingInfo;

      notifyListeners();
    } finally {
      if (showLoader) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> increaseQty(CartItem item) async {
    final index = items.indexWhere((e) => e.id == item.id);

    if (index == -1) return;

    // instant ui
    items[index].quantity++;

    notifyListeners();

    try {
      await repository.updateCart(
        cartItemId: item.id,
        quantity: items[index].quantity,
      );

      // refresh silently
      await getCart(showLoader: false);
    } catch (e) {
      items[index].quantity--;
      notifyListeners();
    }
  }

  Future<void> decreaseQty(CartItem item) async {
    final index = items.indexWhere((e) => e.id == item.id);

    if (index == -1) return;

    if (items[index].quantity == 1) return;

    items[index].quantity--;

    notifyListeners();

    try {
      await repository.updateCart(
        cartItemId: item.id,
        quantity: items[index].quantity,
      );

      await getCart(showLoader: false);
    } catch (e) {
      items[index].quantity++;
      notifyListeners();
    }
  }

  Future<void> removeItem(CartItem item) async {
    final index = items.indexWhere((e) => e.id == item.id);

    if (index == -1) return;

    // remove instantly
    items.removeAt(index);

    notifyListeners();

    try {
      await repository.removeCartItem(item.id);

      await getCart(showLoader: false);
    } catch (e) {
      items.insert(index, item);

      notifyListeners();
    }
  }
}