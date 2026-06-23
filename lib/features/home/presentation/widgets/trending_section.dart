import 'package:cw_fashion/features/all_products/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cw_fashion/features/home/presentation/widgets/product_card.dart';

import '../../../all_products/presentation/pages/all_products_page.dart';

class TrendingSection extends StatelessWidget {
  final String title;
  final List<dynamic> products;

  const TrendingSection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Title
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Container(width: 90, height: 4, color: const Color(0xffC8A648)),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllProductsPage(query: ""),
                  ),
                );
              },
              child: const Text(
                "View All",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 15),

          products.isEmpty
              ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("No Products Found"),
            ),
          )
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length > 8 ? 8 : products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.50,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailPage(
                            productId: product.id,
                          ),
                    ),
                  );
                },
                child: ProductCard(
                  title: product.title ?? "",
                  image: product.imageUrl ?? "",
                  price: "₹${product.flashSalePrice?.toInt() ?? 0}",
                  oldPrice: "₹${product.mrp?.toInt() ?? 0}",
                  sold: "${product.totalSold ?? 0}+ sold",
                  rating: product.rating ?? 0,
                  // discount: product.discountPercent,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
