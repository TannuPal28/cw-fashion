import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [

          const SizedBox(
            width: 40,
            child: Icon(Icons.menu),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.diamond_outlined,size: 18),
                SizedBox(width: 6),
                Text(
                  "CWFASHION",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.search),
              SizedBox(width: 10),
              Icon(Icons.favorite_border),
              SizedBox(width: 10),
              Icon(Icons.shopping_bag_outlined),
              SizedBox(width: 10),
              Text(
                "Sign In",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}