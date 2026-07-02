import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailSummarySection extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;

  const OrderDetailSummarySection({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [

          const Row(
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _row("Subtotal", "₹${subtotal.toInt()}"),

          const SizedBox(height: 12),

          _row(
            "Shipping",
            shipping == 0 ? "Free" : "₹${shipping.toInt()}",
            valueColor: shipping == 0 ? Colors.green : Colors.black,
          ),

          if (discount > 0) ...[
            const SizedBox(height: 12),
            _row(
              "Discount",
              "-₹${discount.toInt()}",
              valueColor: Colors.green,
            ),
          ],

          const Divider(height: 30),

          _row(
            "Total",
            "₹${total.toInt()}",
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        bool isBold = false,
        Color valueColor = Colors.black,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}