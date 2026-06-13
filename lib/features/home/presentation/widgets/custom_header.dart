import 'package:cw_fashion/features/auth/presentation/pages/sign_in_page.dart';
import 'package:cw_fashion/features/home/presentation/widgets/side_menu_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffe5e5e5))),
      ),
      child: Row(
        children: [
          //menu
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

          //logo
          Expanded(
            child: Row(
              children: const [
                Icon(
                  Icons.diamond_outlined,
                  size: 18,
                  color: Color(0xffb79d56),
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    "CWFASHION",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.search),

          const SizedBox(width: 15),

          const Icon(Icons.favorite_border),

          const SizedBox(width: 15),

          const Icon(Icons.shopping_bag_outlined),

          const SizedBox(width: 15),

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
}
