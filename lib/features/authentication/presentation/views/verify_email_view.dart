import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_state.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailBloc()
        ..add(ChangeTimerEvent(time: VerifyEmailBloc.otpTimer)),
      child: Builder(
        builder: (context) {
          return BlocListener(
            bloc: context.read<VerifyEmailBloc>(),
            listener: (context, state) {
              if (state is TimerChangedState) {
                context
                    .read<VerifyEmailBloc>()
                    .add(ChangeTimerEvent(time: state.time));
              }
            },
            child: Scaffold(
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
                          fieldWidth: 64,
                          activeFillColor: Colors.white,
                          inactiveFillColor: AppColors.white,
                          selectedFillColor: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    BlocBuilder(
                      bloc: context.watch<VerifyEmailBloc>(),
                      buildWhen: (previous, current) {
                        if (current is TimerFinishedState) return true;
                        if (previous is TimerFinishedState &&
                            current is TimerChangedState) return true;
                        return false;
                      },
                      builder: (context, state) {
                        if (state is! TimerFinishedState) {
                          return const SizedBox();
                        }
                        return Center(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.gtWalshPro,
                                color: AppColors.par,
                              ),
                              children: [
                                const TextSpan(text: "Did not receive code? "),
                                TextSpan(
                                  text: "Resend Code",
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context
                                          .read<VerifyEmailBloc>()
                                          .add(ResendCodeEvent());
                                    },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder(
                      bloc: context.watch<VerifyEmailBloc>(),
                      buildWhen: (previous, current) {
                        return current is TimerChangedState ||
                            current is TimerFinishedState;
                      },
                      builder: (context, state) {
                        if (state is! TimerChangedState) {
                          return const SizedBox();
                        }
                        return Center(
                          child: Text(
                            state.parsedTime,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: AppFonts.gtWalshPro,
                              color: AppColors.par,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 56),
                    Center(
                      child: CustomButton(
                        text: "Verify Email",
                        textColor: AppColors.white,
                        buttonColor: AppColors.primary,
                        radius: 50,
                        function: () => context
                            .read<VerifyEmailBloc>()
                            .add(VerifyEmailTapEvent(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
