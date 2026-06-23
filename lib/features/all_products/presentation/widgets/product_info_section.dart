import 'package:flutter/material.dart';
import '../../data/models/product_detail_model.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductData product;

  const ProductInfoSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final variant =
    product.variants.isNotEmpty ? product.variants.first : null;

    final price = variant?.price ?? product.minPrice;
    final mrp = variant?.mrp ?? product.mrp;

    final discount =
    mrp == 0 ? 0 : (((mrp - price) / mrp) * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Brand
          Text(
            product.brand.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 10),

          /// Title
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 10),

          /// Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Text(
                "₹$price",
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                "₹$mrp",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                "$discount% OFF",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}