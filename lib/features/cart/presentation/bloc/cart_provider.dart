import 'package:flutter/material.dart';

import '../../data/models/address_response_model.dart';
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

  List<AddressModel> addresses = [];
  bool addressLoading = false;

  Future<void> getAddresses() async {
    try {
      addressLoading = true;
      notifyListeners();

      final response = await repository.getAddress();

      addresses = response.addresses;
      if (addresses.isNotEmpty) {
        selectedAddress ??= addresses.firstWhere(
              (e) => e.isDefault,
          orElse: () => addresses.first,
        );
      }
    } finally {
      addressLoading = false;
      notifyListeners();
    }
  }

  bool addAddressLoading = false;

  Future<bool> addAddress({
    required String fullName,
    required String phone,
    required String alternatePhone,
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String pincode,
    required String label,
    required bool isDefault,
  }) async {
    try {
      addAddressLoading = true;
      notifyListeners();

      await repository.addAddress({
        "fullName": fullName,
        "phone": phone,
        "alternatePhone": alternatePhone,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "landmark": landmark,
        "city": city,
        "state": state,
        "pincode": pincode,
        "label": label,
        "isDefault": isDefault,
      });

      await getAddresses();

      return true;
    } catch (e) {
      return false;
    } finally {
      addAddressLoading = false;
      notifyListeners();
    }
  }

  /// Selected Address
  AddressModel? selectedAddress;

  void selectAddress(AddressModel address) {
    selectedAddress = address;
    notifyListeners();
  }
}