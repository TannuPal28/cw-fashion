import 'package:cw_fashion/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:cw_fashion/features/cart/presentation/widgets/coupon_section.dart';
import 'package:cw_fashion/features/cart/presentation/widgets/order_summary_section.dart';
import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CartProvider>().getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
          ),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {},
              child: const Text(
                "CHECKOUT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.items.isEmpty) {
            return const Center(child: Text("Cart Empty"));
          }

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const CustomHeader(),

              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Shopping Cart",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.items.length,
                itemBuilder: (context, index) {
                  final item = provider.items[index];

                  return CartItemCard(
                    image: item.image,
                    title: item.name,
                    vendor: item.vendor,
                    color: item.color,
                    size: item.size,
                    price: item.price,
                    mrp: item.mrp,
                    quantity: item.quantity,

                    onIncrease: () {
                      provider.increaseQty(item);
                    },

                    onDecrease: () {
                      provider.decreaseQty(item);
                    },

                    onRemove: () {
                      provider.removeItem(item);
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              const CouponSection(),

              const SizedBox(height: 20),

              OrderSummarySection(
                subTotal: provider.shippingInfo?.subtotal.toDouble() ?? 0,
                shipping: provider.shippingInfo?.subtotal.toDouble() ?? 0,
                discount: provider.shippingInfo?.discount.toDouble() ?? 0,
                total: provider.shippingInfo?.total.toDouble() ?? 0,
              ),

              const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }
}
