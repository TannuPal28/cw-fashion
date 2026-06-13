import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
            width: 25,
          ),
          const SizedBox(width: 15),
          const Text(
            "Continue with Google",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
