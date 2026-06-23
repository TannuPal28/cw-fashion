import 'package:flutter/material.dart';
import '../../data/models/product_detail_model.dart';

class DescriptionSection extends StatelessWidget {
  final ProductData product;

  const DescriptionSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Divider(color: Colors.grey.shade300),


          const Text(
            "Description",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            product.description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff4E5968),
              height: 1.8,
            ),
          ),

          const SizedBox(height: 5),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 15),

          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Sold by ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: product.vendor.storeName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 15),

          const Text(
            "Customer Reviews",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              chip("Latest", true),
              chip("Highest Rating", false),
              chip("Lowest Rating", false),
              chip("With Photos", false),
              chip("Verified", false),
            ],
          ),

          const SizedBox(height: 70),

          const Center(
            child: Text(
              "No reviews yet. Be the first to review!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  static Widget chip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black54,
          fontSize: 17,
        ),
      ),
    );
  }
}