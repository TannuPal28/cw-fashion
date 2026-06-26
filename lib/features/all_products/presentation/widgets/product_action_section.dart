import 'package:cw_fashion/features/all_products/presentation/bloc/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductActionSection extends StatefulWidget {
  final String productId;

  const ProductActionSection({super.key, required this.productId});

  @override
  State<ProductActionSection> createState() => _ProductActionSectionState();
}

class _ProductActionSectionState extends State<ProductActionSection> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductDetailProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          /// Quantity
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (qty > 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  child: Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Text(
                    qty.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      qty++;
                    });
                  },
                  child: Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: const Text("+", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          /// Add To Cart
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text(
                  "ADD TO CART",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// Wishlist
          GestureDetector(
            onTap: provider.wishlistLoading
                ? null
                : () {
                    context.read<ProductDetailProvider>().toggleWishlist(
                      widget.productId,
                    );
                  },
            child: Container(
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: provider.wishlistLoading
                  ? const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : Icon(
                      provider.isProductWishlisted(widget.productId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: provider.isProductWishlisted(widget.productId)
                          ? Colors.red
                          : Colors.black,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
