import 'package:flutter/material.dart';
import 'package:funconnect/constants/colors.dart';
import 'package:funconnect/constants/custom_button.dart';
import 'package:funconnect/constants/fonts.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({Key? key}) : super(key: key);
  static const successGif = "assets/gifs/success_gif.gif";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image.asset(successGif),
            ),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          const Center(
            child: Text(
              "Yaaaay!!!",
              style: TextStyle(
                fontFamily: AppFonts.gtWalshPro,
                fontSize: 24,
                color: AppColors.grey,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: Center(
              child: Text(
                "Congratulations you can now explore your favourite places, events ant locations and make new friends",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.gtWalshPro,
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          const Spacer(),
          CustomButton(
            text: "Dive in",
            buttonColor: AppColors.primary,
            height: 70,
            radius: 50,
            fontSize: 20,
            function: () {},
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
