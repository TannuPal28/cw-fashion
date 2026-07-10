import 'package:cw_fashion/features/all_products/presentation/bloc/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/bloc/cart_provider.dart';
import '../../../wishlist/presentation/bloc/wishlist_provider.dart';

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
                onPressed: provider.cartLoading
                    ? null
                    : () async {
                        final success = await provider.addToCart(qty);
                        if (!context.mounted) return;

                        if (success) {
                          await context.read<CartProvider>().getCart(showLoader: false);

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to cart")),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(),
                ),
                child: provider.cartLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
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
                : () async {
              await context.read<ProductDetailProvider>().toggleWishlist(
                widget.productId,
              );

              if (!context.mounted) return;

              await context.read<WishlistProvider>().getWishlist();
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
