import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  final String? oldPrice;
  final String? sold;
  final String? discount;
  final double? rating;
  final int? reviews;
  final bool showSaleBadge;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.oldPrice,
    this.sold,
    this.discount,
    this.rating,
    this.reviews,
    this.showSaleBadge = false,
  });

  bool get isValidImage =>
      image.startsWith("http://") || image.startsWith("https://");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          SizedBox(
            height: 180,
            width: double.infinity,

            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: isValidImage
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.image, size: 50);
                          },
                        )
                      : const Icon(Icons.image, size: 50),
                ),

                if (discount != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: Colors.red,
                      child: Text(
                        discount!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                if (showSaleBadge)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: Colors.red,
                      child: const Text(
                        "SALE",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          /// TITLE
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 4),

          /// PRICE
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (oldPrice != null) ...[
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    oldPrice!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 4),

          /// RATING
          if (rating != null || sold != null)
            Row(
              children: [
                if (rating != null) ...[
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 2),
                  Text(rating.toString(), style: const TextStyle(fontSize: 12)),
                ],

                const Spacer(),

                if (sold != null)
                  Flexible(
                    child: Text(
                      sold!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
