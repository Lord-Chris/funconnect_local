import 'package:flutter/material.dart';
import 'package:funconnect/constants/colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  static const welcomeImage = "assets/images/sign_in_image.jpeg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            welcomeImage,
            fit: BoxFit.fitWidth,
          ),
          const Spacer(),
        ],
      ),
      bottomSheet: Container(
        height: 600,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children:  [
            Text("Welcome Back"),
            Text("Jump back in where you stopped"),
            
          ],
        ),
      ),
    );
  }
}
