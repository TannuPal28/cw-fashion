import 'package:cw_fashion/features/all_products/presentation/bloc/product_detail_provider.dart';
import 'package:cw_fashion/features/all_products/presentation/widgets/delivery_section.dart';
import 'package:cw_fashion/features/all_products/presentation/widgets/description_section.dart';
import 'package:cw_fashion/features/all_products/presentation/widgets/product_image_slider.dart';
import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home/presentation/widgets/product_card.dart';
import '../../data/models/product_detail_model.dart';
import '../widgets/color_selector.dart';
import '../widgets/product_action_section.dart';
import '../widgets/product_info_section.dart';
import '../widgets/size_selector.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<ProductDetailProvider>();

      provider.getProductDetail(widget.productId);
      provider.getRelatedProducts(widget.productId);
      provider.getReviews(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final product = provider.product;

          if (product == null) {
            return const Center(child: Text("No Product Found"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(),
                ProductImageSlider(product: product),
                const SizedBox(height: 20),
                ProductInfoSection(product: product),
                const DeliverySection(),
                const SizedBox(height: 20),
                ColorSelector(
                  product: product,
                  onColorSelected: (color) {
                    context.read()<ProductDetailProvider>().selectColor(color);
                  },
                ),
                SizeSelector(
                  product: product,
                  selectedColor: provider.selectedColor,
                  onSizeSelected: (variant) {
                    context
                        .read<ProductDetailProvider>()
                        .selectSize(variant.size);
                  },
                ),
                ProductActionSection(productId: widget.productId,),
                const SizedBox(height: 25),
                DescriptionSection(product: product),
                Consumer<ProductDetailProvider>(
                  builder: (context, provider, child) {
                    if (provider.relatedLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (provider.relatedProducts.isEmpty) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "You May Also Like",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.relatedProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .55,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemBuilder: (context, index) {
                              final item = provider.relatedProducts[index];
                              final discount =
                                  (((item.mrp - item.price) / item.mrp) * 100)
                                      .round();

                              return ProductCard(
                                image: item.image,
                                title: item.title,
                                price: "₹${item.price}",
                                oldPrice: "₹${item.mrp}",
                                sold: "${item.sold}+ sold",
                                rating: item.rating,
                                reviews: item.reviews,
                                discount: "-$discount%",
                              );
                            },

                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
