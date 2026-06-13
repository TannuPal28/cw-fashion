import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';

import '../widgets/create_account_card.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: const CreateAccountCard(),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      )),
    );
  }
}
