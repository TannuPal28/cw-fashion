import 'package:flutter/cupertino.dart';

import 'brand_card.dart';

class TopBrands extends StatelessWidget {
  const TopBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TOP BRANDS",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (_, index) {
              return const BrandCard(
                coverImage:
                    "https://images.unsplash.com/photo-1521572267360-ee0c2909d518",
                logoImage:
                    "https://cdn-icons-png.flaticon.com/512/732/732084.png",
                brandName: "ZARA",
              );
            },
          ),
        ],
      ),
    );
  }
}
