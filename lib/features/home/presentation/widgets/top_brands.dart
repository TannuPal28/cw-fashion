import 'package:cw_fashion/features/home/presentation/bloc/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brand_card.dart';

class TopBrands extends StatelessWidget {
  const TopBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.brandsIsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.brands.isEmpty) {
          return const SizedBox.shrink();
        }
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
                itemCount: provider.brands.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (_, index) {
                  final brand= provider.brands[index];
                  return BrandCard(
                    coverImage: brand.coverImageUrl,
                    logoImage: brand.logoUrl,
                    brandName: brand.name.toUpperCase(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
