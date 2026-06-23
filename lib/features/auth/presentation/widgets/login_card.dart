import 'package:cw_fashion/features/auth/presentation/bloc/auth_provider.dart';
import 'package:cw_fashion/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:cw_fashion/features/auth/presentation/widgets/google_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../pages/sign_up_page.dart';
import 'custom_auth_textfield.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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

          CustomAuthTextField(
            controller: emailController,
            hintText: "Enter your email",
          ),

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
            controller: passwordController,
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
          Consumer<AuthProvider>(
            builder: (_, provider, __) {
              return SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          final success = await provider.login(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login Successful")),
                            );

                            // Home Page
                            Navigator.pushReplacement(
                              context,

                              MaterialPageRoute(builder: (_) => const HomePage()),
                            );
                          }
                        },
                  child: provider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("SIGN IN"),
                ),
              );
            },
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
