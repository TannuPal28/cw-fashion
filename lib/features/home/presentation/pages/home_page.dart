import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:cw_fashion/features/home/presentation/widgets/flash_sale.dart';
import 'package:cw_fashion/features/home/presentation/widgets/top_brands.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [

              CustomHeader(),

              SizedBox(height: 10),

              BannerSection(),

              SizedBox(height: 20),

              FlashSaleSection(),

              SizedBox(height: 20),
              CategorySection(),

              SizedBox(height: 20),

              TrendingSection(title: "Trending Now",),

              SizedBox(height: 20),

              OfferBanner(),

              SizedBox(height: 20),
              TrendingSection(title: "Best Seller",),
              SizedBox(height: 20),
              TrendingSection(title: "New Arrivals",),
              SizedBox(height: 20),
              TopBrands(),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
