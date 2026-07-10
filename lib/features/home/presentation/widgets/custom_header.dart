import 'package:cw_fashion/features/auth/presentation/pages/sign_in_page.dart';
import 'package:cw_fashion/features/cart/presentation/pages/cart_page.dart';
import 'package:cw_fashion/features/home/presentation/widgets/side_menu_drawer.dart';
import 'package:cw_fashion/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/auth_manager.dart';
import '../../../all_products/presentation/pages/all_products_page.dart';
import '../../../cart/presentation/bloc/cart_provider.dart';
import '../../../wishlist/presentation/bloc/wishlist_provider.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isSearching = false;
  bool isLoggedIn = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadToken();

  }

  Future<void> loadToken() async {
    isLoggedIn = await AuthManager.isLoggedIn();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffe5e5e5))),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.2),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: isSearching ? _searchHeader() : _normalHeader(),
      ),
    );
  }

  Widget _normalHeader() {
    return Container(
      key: const ValueKey("normal"),
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "",
                pageBuilder: (_, __, ___) {
                  return const SideMenuDrawer();
                },
              );
            },
            child: const Icon(Icons.menu, size: 28),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Row(
              children: const [
                Icon(
                  Icons.diamond_outlined,
                  size: 18,
                  color: Color(0xffb79d56),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    "CWFASHION",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                isSearching = true;
              });
            },
            child: const Icon(Icons.search),
          ),

          const SizedBox(width: 15),

          Consumer<WishlistProvider>(
            builder: (_, wishlistProvider, __) {

              return buildBadge(

                count: wishlistProvider.wishlistCount,

                child: const Icon(Icons.favorite_border),

                onTap: () async {

                  if (!isLoggedIn) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignInPage(),
                      ),
                    );

                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WishlistPage(),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(width: 15),

          Consumer<CartProvider>(
            builder: (_, cartProvider, __) {

              return buildBadge(

                count: cartProvider.cartCount,

                child: const Icon(Icons.shopping_bag_outlined),

                onTap: () async {

                  if (!isLoggedIn) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignInPage(),
                      ),
                    );

                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartPage(),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(width: 15),

          if (!isLoggedIn)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInPage()),
                );
              },
              child: const Text(
                "Sign In",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }

  Widget _searchHeader() {
    return Container(
      key: const ValueKey("search"),
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search products...",
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllProductsPage(query: searchController.text),
                ),
              );
            },
            child: Container(
              height: 48,
              width: 48,
              color: Colors.black,
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),

          const SizedBox(width: 15),

          GestureDetector(
            onTap: () {
              searchController.clear();

              setState(() {
                isSearching = false;
              });
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildBadge({
    required Widget child,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          child,

          if (count > 0)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$count",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
