import 'package:carousel_slider/carousel_slider.dart';
import 'package:cw_fashion/features/home/presentation/bloc/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({super.key});

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.bannerIsLoading) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.banners.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                itemCount: provider.banners.length,
                itemBuilder: (context, index, realIndex) {
                  final banner= provider.banners[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        banner.imageUrl,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(.15),
                              Colors.black.withOpacity(.55),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              banner.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              banner.subtitle,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 20),

                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                              ),
                              child: const Text(
                                "SHOP NOW",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  height: 220,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),

              Positioned(
                bottom: 25,
                child: Row(
                  children: List.generate(
                    provider.banners.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == index ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.white54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
