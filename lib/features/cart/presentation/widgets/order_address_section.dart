import 'package:cw_fashion/features/cart/data/models/address_response_model.dart';
import 'package:cw_fashion/features/cart/data/models/order_response.dart';
import 'package:flutter/material.dart';

class OrderAddressSection extends StatelessWidget {
  final String title;
  final ShippingAddress address;

  const OrderAddressSection({
    super.key,
    required this.title,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            address.fullName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 8),

          Text(address.phone),
          Text(address.addressLine1),
          Text(address.addressLine2),
          Text(address.landmark),
          Text("${address.city}, ${address.state}"),
          Text(address.pincode),
          Text(address.country),
        ],
      ),
    );
  }
}