import 'package:cw_fashion/features/all_products/presentation/pages/all_products_page.dart';
import 'package:cw_fashion/features/cart/presentation/pages/cart_page.dart';
import 'package:cw_fashion/features/home/presentation/pages/home_page.dart';
import 'package:cw_fashion/features/my_orders/presentation/pages/my_orders_page.dart';
import 'package:cw_fashion/features/profile/presentation/pages/profile_page.dart';
import 'package:cw_fashion/features/wallet/presentation/pages/wallet_page.dart';
import 'package:cw_fashion/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/auth_manager.dart';
import '../../../auth/presentation/pages/sign_in_page.dart';
import '../../../auth/presentation/pages/sign_up_page.dart';

class SideMenuDrawer extends StatefulWidget {
  const SideMenuDrawer({super.key});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    isLoggedIn = await AuthManager.isLoggedIn();
    setState(() {});
  }

  Widget menuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.35),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .72,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xffeeeeee)),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.diamond_outlined,
                        color: Color(0xffb79d56),
                      ),
                      const SizedBox(width: 10),

                      const Text(
                        "CWFASHION",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        menuItem("Home", () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                          );
                        }),

                        menuItem("All Products", () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllProductsPage(query: ''),
                            ),
                          );
                        }),

                        menuItem("Wishlist", () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => WishlistPage()));
                        }),

                        menuItem("Cart (0)", () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage()));
                        }),

                        const Divider(),

                        if (!isLoggedIn) ...[
                          menuItem("Sign In", () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignInPage(),
                              ),
                            );
                          }),

                          menuItem("Create Account", () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpPage(),
                              ),
                            );
                          }),
                        ] else ...[
                          menuItem("Profile", () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfilePage(),
                              ),
                            );
                          }),

                          menuItem("Orders", () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyOrdersPage(),
                              ),
                            );
                          }),

                          menuItem("My Reviews", () {}),

                          menuItem("Wallet", () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WalletPage(),
                              ),
                            );
                          }),

                          menuItem("Refer & Earn", () {}),

                          menuItem("Help Center", () {}),

                          const Divider(),

                          menuItem("Logout", () async {
                            await AuthManager.logout();

                            if (!mounted) return;

                            setState(() {
                              isLoggedIn = false;
                            });

                            Navigator.pop(context);
                          }),
                        ],

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}
