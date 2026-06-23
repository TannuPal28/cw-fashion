import 'package:flutter/material.dart';
import '../../data/models/product_detail_model.dart';

class SizeSelector extends StatefulWidget {
  final ProductData product;
  final String selectedColor;
  final Function(ProductVariant) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.product,
    required this.selectedColor,
    required this.onSizeSelected,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedIndex = 0;

  List<ProductVariant> variants = [];

  @override
  void didUpdateWidget(covariant SizeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    variants = widget.product.variants
        .where((e) => e.color == widget.selectedColor)
        .toList();

    if (variants.isNotEmpty) {
      selectedIndex = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSizeSelected(variants.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    variants = widget.product.variants
        .where((e) => e.color == widget.selectedColor)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Size: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: widget.selectedColor.isEmpty
                      ? "Select color first"
                      : "Select",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: List.generate(variants.length, (index) {

              final selected = selectedIndex == index;

              return GestureDetector(
                onTap: () {

                  setState(() {
                    selectedIndex = index;
                  });

                  widget.onSizeSelected(variants[index]);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 14),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    variants[index].size,
                    style: TextStyle(
                      fontSize:18,
                      color: selected
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }
}