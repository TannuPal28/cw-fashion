import 'package:flutter/cupertino.dart';

import 'category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Shop by Category",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            "View All Categories →",
            style: TextStyle(
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 25),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const[
                CategoryCard(
                  title: "Men",
                ),

                SizedBox(width: 15),

                CategoryCard(
                  title: "Bottom Wear",
                ),

                SizedBox(width: 15),

                CategoryCard(
                  title: "Jacket",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
