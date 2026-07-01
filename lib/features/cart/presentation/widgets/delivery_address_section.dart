import 'package:flutter/material.dart';

import '../../data/models/address_response_model.dart';

class DeliveryAddressSection extends StatelessWidget {
  final bool hasAddress;
  final AddressModel? address;

  final VoidCallback onAddAddress;
  final VoidCallback onChangeAddress;

  const DeliveryAddressSection({
    super.key,
    required this.hasAddress,
    required this.address,
    required this.onAddAddress,
    required this.onChangeAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DELIVERY ADDRESS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 25),

          if (!hasAddress)
            GestureDetector(
              onTap: onAddAddress,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "No addresses saved. ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: "Add one",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address?.fullName ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  address?.phone ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "${address?.addressType ?? ""}\n"
                      "${address?.city ?? ""}, ${address?.state ?? ""}\n"
                      "${address?.pincode ?? ""}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 18),

                OutlinedButton(
                  onPressed: onChangeAddress,
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text(
                    "CHANGE",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}