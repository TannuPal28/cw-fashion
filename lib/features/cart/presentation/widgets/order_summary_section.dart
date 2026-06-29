import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final double subTotal;
  final double shipping;
  final double discount;
  final double total;

  const OrderSummarySection({
    super.key,
    required this.subTotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "ORDER SUMMARY",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          /// Coupon Box
          Row(
            children: [

              Expanded(
                child: SizedBox(
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "SECOND",
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              SizedBox(
                width: 120,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "APPLY",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Divider(),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal (1 item)",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),
              Text(
                "₹${subTotal.toInt()}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Free",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (discount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Discount",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "-₹${discount.toInt()}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

          if (discount > 0) const SizedBox(height: 10),

          Divider(),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹${total.toInt()}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {},
              child: const Text(
                "PROCEED TO CHECKOUT",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}