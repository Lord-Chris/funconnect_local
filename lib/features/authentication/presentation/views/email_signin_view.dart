import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_event.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../blocs/email_sign_in_bloc/email_sign_in_state.dart';

class EmailSigninView extends StatelessWidget {
  const EmailSigninView({Key? key}) : super(key: key);
  static const topCircle = "assets/svgs/ellipse_137.svg";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailSignInBloc(),
      child: BlocBuilder<EmailSignInBloc, EmailSignInState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.green,
            body: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset(topCircle, width: 150),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      const Text(
                        "Authentication",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: AppFonts.merriweather,
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Keep your data secured",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.gtWalshPro,
                          color: AppColors.primary,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 78),
                      const AppTextField(
                        hint: "Your Email Address",
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: "Get Code",
                        radius: 50,
                        textColor: AppColors.white,
                        buttonColor: AppColors.primary,
                        function: () =>
                            context.read<EmailSignInBloc>().add(GetCodeEvent()),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
