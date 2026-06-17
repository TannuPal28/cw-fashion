import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(imageUrl),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}