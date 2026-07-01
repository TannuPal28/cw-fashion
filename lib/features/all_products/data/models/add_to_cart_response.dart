class AddToCartRequest {
  final String productId;
  final String variantId;
  final int quantity;
  final String color;
  final String size;

  AddToCartRequest({
    required this.productId,
    required this.variantId,
    required this.quantity,
    required this.color,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "variantId": variantId,
      "quantity": quantity,
      "color": color,
      "size": size,
    };
  }
}