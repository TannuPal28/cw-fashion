import 'package:cw_fashion/features/home/presentation/bloc/home_provider.dart';
import 'package:cw_fashion/features/home/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.categoryIsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.category.isEmpty) {
          return const SizedBox.shrink();
        }
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
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 25),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final category = provider.category[index];

                    return CategoryCard(
                      title: category.name,
                      imageUrl: category.imageUrl,
                    );
                  },
                  itemCount: provider.category.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
