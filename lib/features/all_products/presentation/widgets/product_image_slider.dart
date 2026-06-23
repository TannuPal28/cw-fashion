import 'package:flutter/material.dart';
import '../../data/models/product_detail_model.dart';

class ProductImageSlider extends StatefulWidget {
  final ProductData product;

  const ProductImageSlider({
    super.key,
    required this.product,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    return Column(
      children: [

        /// Main Image
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 450,
          width: double.infinity,
          color: const Color(0xffF3F3F3),
          child: Image.network(
            images[currentIndex].url,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 15),

        /// Thumbnail Images
        SizedBox(
          height: 82,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, index) {
              final selected = currentIndex == index;

              return InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected ? Colors.black : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Image.network(
                    images[index].url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}