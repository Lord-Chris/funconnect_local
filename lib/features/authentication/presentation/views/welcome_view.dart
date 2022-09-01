import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/constants/custom_button.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  static const welcomeImage = "assets/images/sign_in_image.jpeg";
  static const emailSvg = "assets/svgs/clarity_email-solid.svg";
  static const googleSvg = "assets/svgs/flat-color-icons_google.svg";
  static const appleLogoSvg = "assets/svgs/applelogo.svg";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Image.asset(
                  welcomeImage,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 700,
                width: double.maxFinite,
                padding: const EdgeInsets.all(48),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.text,
                        fontFamily: AppFonts.merriweather,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Jump back in where you stopped",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.par,
                        fontFamily: AppFonts.gtWalshPro,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 43),
                    CustomButton(
                      text: "Sign in with Email",
                      isImage: true,
                      image: emailSvg,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.par,
                      buttonColor: AppColors.white,
                      borderColor: AppColors.stroke,
                      radius: 50,
                      function: ()=>context.read<WelcomeBloc>().add(EmailSignInEvent(context)),
                    ),
                    const SizedBox(height: 16),
                    const CustomButton(
                      text: "Continue with Google",
                      image: googleSvg,
                      isImage: true,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.par,
                      buttonColor: AppColors.white,
                      borderColor: AppColors.stroke,
                      radius: 50,
                    ),
                    const SizedBox(height: 16),
                    const CustomButton(
                      text: "Sign in with Apple",
                      isImage: true,
                      image: appleLogoSvg,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      textColor: AppColors.white,
                      buttonColor: AppColors.black,
                      radius: 50,
                    ),
                    const SizedBox(height: 25),
                    RichText(
                      textAlign: TextAlign.start,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.gtWalshPro,
                          color: AppColors.par,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  "By sigining in you have read and agreed to our "),
                          TextSpan(
                            text: "Terms of use",
                            style: TextStyle(
                              color: AppColors.secondary,
                            ),
                          ),
                          TextSpan(text: " and read our "),
                          TextSpan(
                            text: "Privacy policy",
                            style: TextStyle(
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
