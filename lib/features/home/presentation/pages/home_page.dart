import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:cw_fashion/features/home/presentation/widgets/flash_sale.dart';
import 'package:cw_fashion/features/home/presentation/widgets/top_brands.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/auth_manager.dart';
import '../bloc/home_provider.dart';
import '../widgets/banner_section.dart';
import '../widgets/category_section.dart';
import '../widgets/offer_banner.dart';
import '../widgets/trending_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomHeader(),

                  const SizedBox(height: 10),

                  const BannerSection(),

                  const SizedBox(height: 20),

                  const FlashSaleSection(),

                  const SizedBox(height: 20),
                  const CategorySection(),

                  const SizedBox(height: 20),
                  provider.featuresIsLoading
                      ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : TrendingSection(
                    title: "Featured Products",
                    products: provider.features,
                  ),
                  const SizedBox(height: 20),

                  provider.trendingIsLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : TrendingSection(
                          title: "Trending Now",
                          products: provider.trending,
                        ),

                  const SizedBox(height: 20),

                  const OfferBanner(),

                  const SizedBox(height: 20),
                  provider.bestSellerIsLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : TrendingSection(
                          title: "Best Seller",
                          products: provider.bestSellers,
                        ),
                  const SizedBox(height: 20),
                  provider.newArrivalIsLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : TrendingSection(
                          title: "New Arrivals",
                          products: provider.newArrivals,
                        ),
                  const SizedBox(height: 20),
                  const TopBrands(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
