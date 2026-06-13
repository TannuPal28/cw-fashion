import 'package:cw_fashion/features/auth/presentation/pages/sign_in_page.dart';
import 'package:cw_fashion/features/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/verify_otp_page.dart';

class CreateAccountCard extends StatelessWidget {
  const CreateAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const Text(
            "Create Account",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              fontFamily: "Serif",
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Join CWFASHION today",
            style: TextStyle(fontSize: 18, color: Color(0xff6B7280)),
          ),

          const SizedBox(height: 40),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Full Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const CustomAuthTextField(hintText: 'John Doe'),
          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const CustomAuthTextField(hintText: 'john@example.com'),

          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Phone",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const CustomAuthTextField(hintText: '+91 9876543210'),
          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Referral Code (optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const CustomAuthTextField(hintText: 'Enter referral code'),

          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const CustomAuthTextField(
            hintText: 'Min 8 characters',
            isPassword: true,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Confirm Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          const CustomAuthTextField(
            hintText: 'Confirm your password',
            isPassword: true,
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VerifyOtpPage(),
                  ),
                );
              },
              child: const Text(
                "Create Account",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInPage()),
                  );
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
