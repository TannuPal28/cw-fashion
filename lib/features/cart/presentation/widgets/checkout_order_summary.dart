import 'package:flutter/material.dart';

import '../../data/models/cart_model.dart';

class CheckoutOrderSummary extends StatelessWidget {
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;
  final VoidCallback onPlaceOrder;

  const CheckoutOrderSummary({
    super.key,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ORDER SUMMARY",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 20),

          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Image.network(item.image, fit: BoxFit.cover),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getColor(item.color),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Flexible(
                              child: Text(
                                item.color,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                item.size,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Qty : ${item.quantity}",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "₹${item.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal (${items.length} items)",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),

              Text(
                "₹${subtotal.toInt()}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),

              Text(
                shipping == 0 ? "Free" : "₹${shipping.toInt()}",
                style: TextStyle(
                  color: shipping == 0 ? Colors.green : Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              Text(
                "₹${total.toInt()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onPlaceOrder,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text(
                "PLACE ORDER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color getColor(String colorName) {
  switch (colorName.toLowerCase()) {
    case "black":
      return Colors.black;
    case "white":
      return Colors.white;
    case "red":
      return Colors.red;
    case "blue":
      return Colors.blue;
    case "green":
      return Colors.green;
    case "pink":
      return Colors.pink;
    case "yellow":
      return Colors.yellow;
    case "grey":
    case "gray":
      return Colors.grey;
    default:
      return Colors.grey;
  }
}
