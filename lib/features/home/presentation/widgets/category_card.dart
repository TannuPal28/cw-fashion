import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  final String title;

  const CategoryCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [

          const CircleAvatar(
            radius: 30,
            backgroundImage:
            NetworkImage(
              "https://picsum.photos/200",
            ),
          ),

          const SizedBox(height: 10),

          Text(title)
        ],
      ),
    );
  }
}