import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../core/presentation/widgets/app_smart_strings.dart';
import '../../../../core/presentation/widgets/app_text.dart';

class VerifyEmailView extends HookWidget {
  final String email;
  const VerifyEmailView({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clipData = useStream(GeneralUtils.checkClipBoard());
    final pinController = useTextEditingController();
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
              body: Stack(
                fit: StackFit.loose,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppSmartString.registerImg),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20.0,
                    child: Container(
                      height: 450,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            AppText.aTAuthVerifyEmailIdText,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.merriweather,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "We’ve sent a code to ",
                                  style: AppTextStyle.whiteMedium,
                                ),
                                TextSpan(
                                  text: GeneralUtils.hideEmail(email),
                                  style: AppTextStyle.whiteMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "\nCheck your spam folder, refresh or try again with\nanother email",
                                  style: AppTextStyle.whiteMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 62),
                          Center(
                            child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              onCompleted: (value) {},
                              onChanged: (value) {},
                              controller: pinController,
                              autoDisposeControllers: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.ash,
                              obscureText: !true,
                              textStyle: AppTextStyle.whiteBold.copyWith(
                                fontSize: 20.0,
                              ),
                              obscuringCharacter: "*",
                              backgroundColor: AppColors.transparent,
                              enableActiveFill: true,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                selectedColor: AppColors.primary,
                                activeColor: AppColors.primary,
                                inactiveColor: AppColors.ash,
                                fieldHeight: 64.r,
                                fieldWidth: 64.r,
                                activeFillColor: AppColors.transparent,
                                inactiveFillColor: AppColors.transparent,
                                selectedFillColor: AppColors.transparent,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: clipData.hasData,
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: TextButton(
                                onPressed: () =>
                                    pinController.text = clipData.data!,
                                child: Text(
                                  "Paste",
                                  style: AppTextStyle.blacklight,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
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
                                      color: AppColors.primary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppText.aTAuthDNReceiveCodeText,
                                        style: AppTextStyle.whiteMedium,
                                      ),
                                      TextSpan(
                                        text: AppText.aTAuthResendCodeText,
                                        style:
                                            AppTextStyle.whiteMedium.copyWith(
                                          color: AppColors.primary,
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
                                    color: AppColors.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                          AppOrangeBtn(
                            label: AppText.aTAuthVerifyEmailText,
                            onTap: () => context
                                .read<VerifyEmailBloc>()
                                .add(VerifyEmailTapEvent(
                                  email: email,
                                  otp: pinController.text,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
