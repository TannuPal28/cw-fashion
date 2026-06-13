import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';

import '../widgets/login_card.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(),
              const SizedBox(height:50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginCard(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
