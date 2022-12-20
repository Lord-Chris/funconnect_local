import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import 'shared/components/_components.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({Key? key}) : super(key: key);
  static const successGif = "assets/gifs/success_gif.gif";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
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
                color: AppColors.primary,
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
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          const Spacer(),
          AppButton(
            label: "Dive in",
            buttonColor: AppColors.primary,
            height: 70,
            borderRadius: 50,
            labelSize: 20,
            onTap: () {},
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
