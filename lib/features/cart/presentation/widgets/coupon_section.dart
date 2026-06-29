import 'package:flutter/material.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Heading
          Row(
            children: const [
              Icon(
                Icons.local_offer_outlined,
                color: Color(0xffd4a017),
              ),
              SizedBox(width: 10),
              Text(
                "AVAILABLE COUPONS",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: .5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _couponCard(
            code: "SECOND",
            discount: "₹200 OFF",
            description: "apply it",
            minAmount: "Min. ₹5000",
            daysLeft: "4 days left",
          ),

          const SizedBox(height: 18),

          _couponCard(
            code: "FIRST",
            discount: "₹100 OFF",
            description: "gift you",
            minAmount: "Min. ₹650",
            daysLeft: "4 days left",
          ),
        ],
      ),
    );
  }

  Widget _couponCard({
    required String code,
    required String discount,
    required String description,
    required String minAmount,
    required String daysLeft,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      code,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        discount,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5  ),

                Wrap(
                  spacing: 12,
                  children: [
                    Text(
                      minAmount,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      daysLeft,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 90,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffc99a06),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Apply",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}