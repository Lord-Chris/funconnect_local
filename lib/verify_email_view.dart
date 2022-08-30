import 'package:flutter/material.dart';
import 'package:funconnect/constants/custom_button.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 30),
            const Text(
              "Verify Email Address",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.merriweather,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "An OTP has been sent to kings****@gmail.com",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: AppFonts.gtWalshPro,
                color: AppColors.par,
              ),
            ),
            const SizedBox(height: 62),
            Center(
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                onCompleted: (value) {},
                onChanged: (value) {},
                // controller: pinController,
                autoDisposeControllers: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                cursorColor: AppColors.black,
                obscureText: true,
                obscuringCharacter: "*",
                backgroundColor: AppColors.transparent,
                enableActiveFill: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: AppColors.primary,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.grey.withOpacity(0.2),
                  fieldHeight: 64,
                  activeFillColor: Colors.white,
                  inactiveFillColor: AppColors.white,
                  selectedFillColor: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.gtWalshPro,
                    color: AppColors.par,
                  ),
                  children: [
                    TextSpan(text: "Did not receive code? "),
                    TextSpan(
                      text: "Resend Code",
                      style: TextStyle(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "(1:28)",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppFonts.gtWalshPro,
                  color: AppColors.par,
                ),
              ),
            ),
            const SizedBox(height: 56),
            const Center(
              child: CustomButton(
                text: "Verify Email",
                textColor: AppColors.white,
                buttonColor: AppColors.primary,
                radius: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
