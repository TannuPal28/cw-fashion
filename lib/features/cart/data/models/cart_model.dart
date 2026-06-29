class CartResponse {
  final bool success;
  final Cart cart;

  CartResponse({
    required this.success,
    required this.cart,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json["success"],
      cart: Cart.fromJson(json["cart"]),
    );
  }
}

class Cart {
  final List<CartItem> items;
  final ShippingInfo shippingInfo;

  Cart({
    required this.items,
    required this.shippingInfo,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json["items"] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      shippingInfo: ShippingInfo.fromJson(json["shippingInfo"]),
    );
  }
}

class CartItem {
  final String id;
  final String name;
  final String image;
  final String color;
  final String size;
  int quantity;
  final int price;
  final int mrp;
  final String vendor;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
    required this.mrp,
    required this.vendor,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["_id"],
      name: json["name"],
      image: json["image"],
      color: json["color"],
      size: json["size"],
      quantity: json["quantity"],
      price: json["price"],
      mrp: json["mrp"],
      vendor: json["vendor"]["storeName"],
    );
  }
}

class ShippingInfo {
  final int subtotal;
  final int discount;
  final int charge;
  final int total;

  ShippingInfo({
    required this.subtotal,
    required this.discount,
    required this.charge,
    required this.total,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      subtotal: json["subtotal"],
      discount: json["discount"],
      charge: json["charge"],
      total: json["total"],
    );
  }
}