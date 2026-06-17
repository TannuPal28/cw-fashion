import 'package:cw_fashion/features/home/presentation/bloc/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_card.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Container(
          color: const Color(0xffF9ECEC),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "FLASH SALE",
                style: TextStyle(
                  color: Colors.red,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                "Limited Time Offers",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  _timerBox(provider.hours, "Hrs"),

                  _timerBox(provider.minutes, "Min"),

                  _timerBox(provider.seconds, "Sec"),

                  const Spacer(),

                  const Text(
                    "View All →",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (provider.flashSaleIsLoading)
                const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (provider.flashSaleProducts.isEmpty)
                const SizedBox(
                  height: 100,
                  child: Center(child: Text("No Flash Sale Products")),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.flashSaleProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (_, index) {
                    final product = provider.flashSaleProducts[index];

                    return ProductCard(
                      title: product.title,
                      image: product.imageUrl,
                      price: "₹${product.flashSalePrice.toInt()}",
                      oldPrice: "₹${product.mrp.toInt()}",
                      sold: "${product.totalSold}+ sold",
                      rating: product.rating,
                      discount: product.discountPercent,
                      showSaleBadge: true,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _timerBox(String value, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
