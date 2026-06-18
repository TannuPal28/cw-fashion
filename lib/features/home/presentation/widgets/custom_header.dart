import 'package:cw_fashion/features/auth/presentation/pages/sign_in_page.dart';
import 'package:cw_fashion/features/home/presentation/widgets/side_menu_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../all_products/presentation/pages/all_products_page.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          return SlideTransition(position: Tween<Offset>(
            begin: const Offset(0, -0.2),
            end: Offset.zero
          ).animate(animation),
          child: FadeTransition(opacity: animation,child: child
            ,),);
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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

          const Icon(Icons.favorite_border),

          const SizedBox(width: 15),

          const Icon(Icons.shopping_bag_outlined),

          const SizedBox(width: 15),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInPage(),
                ),
              );
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
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
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15),
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
                  builder: (_) => AllProductsPage(query:searchController.text ,),
                ),
              );
            },
            child: Container(
              height: 48,
              width: 48,
              color: Colors.black,
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
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
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
