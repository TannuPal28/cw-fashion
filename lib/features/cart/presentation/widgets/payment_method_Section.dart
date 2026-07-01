import 'package:flutter/material.dart';

class PaymentMethodSection extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onChanged;

  const PaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
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
            "PAYMENT METHOD",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 22),

          _paymentTile(
            value: "cod",
            title: "Cash on Delivery",
            subtitle: "Pay when you receive your order",
          ),

          const SizedBox(height: 16),

          _paymentTile(
            value: "wallet",
            title: "Wallet",
            subtitle: "Pay using your wallet balance",
          ),

          const SizedBox(height: 16),

          _paymentTile(
            value: "online",
            title: "Credit / Debit Card / UPI",
            subtitle: "Visa, Mastercard, RuPay, Net Banking, UPI",
          ),
        ],
      ),
    );
  }

  Widget _paymentTile({
    required String value,
    required String title,
    required String subtitle,
  }) {
    final isSelected = selectedMethod == value;

    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Colors.black
                : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Radio<String>(
              value: value,
              groupValue: selectedMethod,
              activeColor: Colors.black,
              onChanged: (val) {
                if (val != null) {
                  onChanged(val);
                }
              },
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}