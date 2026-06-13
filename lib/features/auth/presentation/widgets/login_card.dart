import 'package:cw_fashion/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:cw_fashion/features/auth/presentation/widgets/google_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/sign_up_page.dart';
import 'custom_auth_textfield.dart';

class LoginCard extends StatelessWidget {
  LoginCard({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        children: [
          const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: "PlayfairDisplay",
            ),
          ),

          const SizedBox(height: 10),
          Text(
            "Sign in to your account",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          const SizedBox(height: 40),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 12),

          CustomAuthTextField(hintText: "Enter your email"),

          const SizedBox(height: 25),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),

          CustomAuthTextField(
            hintText: "Enter your password",
            isPassword: true,
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
              ),
            ),
          ),

          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {},
              child: const Text(
                "SIGN IN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "or continue with",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
          const SizedBox(height: 30),

          const GoogleSigninButton(),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpPage()),
                  );
                },
                child: const Text(
                  "Create one",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 30),

          Text(
            "Demo: admin@luxefashion.com / Admin@1234",
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
