import 'package:cw_fashion/features/all_products/presentation/bloc/product_detail_provider.dart';
import 'package:cw_fashion/features/all_products/presentation/widgets/delivery_section.dart';
import 'package:cw_fashion/features/all_products/presentation/widgets/description_section.dart';
import 'package:cw_fashion/features/all_products/presentation/widgets/product_image_slider.dart';
import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String selectedColor = "";
  ProductVariant? selectedVariant;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductDetailProvider>().getProductDetail(widget.productId);
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
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                SizeSelector(
                  product: product,
                  selectedColor: selectedColor,
                  onSizeSelected: (variant) {
                    setState(() {
                      selectedVariant = variant;
                    });
                  },
                ),
                const ProductActionSection(),
                const SizedBox(height: 25,),
                DescriptionSection(product: product),],
            ),
          );
        },
      ),
    );
  }
}
