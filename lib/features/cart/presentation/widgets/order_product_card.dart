import 'package:flutter/material.dart';

import '../../data/models/order_response.dart';


class OrderProductCard extends StatelessWidget {
  final OrderItem item;

  const OrderProductCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 90,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Image.network(
              item.image,
              fit: BoxFit.cover,
            ),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Color : ${item.color}",
                  style: TextStyle(color: Colors.grey.shade700),
                ),

                const SizedBox(height: 5),

                Text(
                  "Size : ${item.size}",
                  style: TextStyle(color: Colors.grey.shade700),
                ),

                const SizedBox(height: 5),

                Text(
                  "Qty : ${item.quantity}",
                  style: TextStyle(color: Colors.grey.shade700),
                ),

                const SizedBox(height: 10),

                Text(
                  "₹${item.price}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}