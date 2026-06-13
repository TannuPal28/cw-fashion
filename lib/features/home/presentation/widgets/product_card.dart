import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String oldPrice;
  final String sold;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.sold,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "-55%",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontSize: 16)),

        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(width: 8),

            Text(
              oldPrice,
              style: const TextStyle(decoration: TextDecoration.lineThrough),
            ),
          ],
        ),

        const SizedBox(height: 5),

        Text(sold, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
