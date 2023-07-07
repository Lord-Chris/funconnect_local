import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/authentication/presentation/verify_email/bloc/verify_email_bloc.dart';
import 'package:funconnect/features/authentication/presentation/verify_email/bloc/verify_email_event.dart';
import 'package:funconnect/features/authentication/presentation/verify_email/bloc/verify_email_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../shared/components/app_orange_button.dart';
import '../../data/dto/request_otp_response.dart';
import '../../../../shared/components/app_black_modal.dart';

class VerifyEmailView extends StatefulHookWidget {
  final RequestOtpResponse response;
  const VerifyEmailView({
    required this.response,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context
        .read<VerifyEmailBloc>()
        .add(ChangeTimerEvent(time: VerifyEmailBloc.otpTimer));
  }

  @override
  Widget build(BuildContext context) {
    final clipData = useStream(GeneralUtils.checkClipBoard());
    final pinController = useTextEditingController();
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
      builder: (context, state) {
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
            backgroundColor: AppColors.primary,
            body: SafeArea(
              top: false,
              child: AppBlackModalWidget(
                showBackButton: true,
                topIcon: SvgPicture.asset(
                  AppAssets.emailIconSvg,
                  colorFilter:
                      const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                context.read<VerifyEmailBloc>().isFirstTime
                                    ? AppText.aTAuthVerifyEmailIdText
                                    : "Enter OTP",
                                style: AppTextStyles.medium24.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    if (context
                                        .read<VerifyEmailBloc>()
                                        .isFirstTime)
                                      TextSpan(
                                        text: "We’ve sent a code to ",
                                        style: AppTextStyles.light14.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    if (!context
                                        .read<VerifyEmailBloc>()
                                        .isFirstTime)
                                      TextSpan(
                                        text: "We’ve sent an OTP to ",
                                        style: AppTextStyles.light14.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    TextSpan(
                                      text: GeneralUtils.hideEmail(
                                          widget.response.email),
                                      style: AppTextStyles.medium14.copyWith(
                                        color: context
                                                .read<VerifyEmailBloc>()
                                                .isFirstTime
                                            ? AppColors.primary
                                            : AppColors.white,
                                      ),
                                    ),
                                    if (context
                                        .read<VerifyEmailBloc>()
                                        .isFirstTime)
                                      TextSpan(
                                        text:
                                            "\nCheck your spam folder, refresh or try again with\nanother email",
                                        style: AppTextStyles.light14.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              Center(
                                child: PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  onChanged: (value) {},
                                  controller: pinController,
                                  autoDisposeControllers: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  validator: context.validateOtp,
                                  cursorColor: AppColors.ash,
                                  obscureText: !true,
                                  textStyle: AppTextStyles.bold20,
                                  obscuringCharacter: "*",
                                  backgroundColor: AppColors.transparent,
                                  enableActiveFill: true,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(10),
                                    borderWidth: 1,
                                    selectedColor: AppColors.primary,
                                    activeColor: AppColors.primary,
                                    inactiveColor: AppColors.ash,
                                    fieldHeight: 49.r,
                                    fieldWidth: 49.r,
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
                                      style: AppTextStyles.light12.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              BlocBuilder(
                                bloc: context.watch<VerifyEmailBloc>(),
                                buildWhen: (previous, current) {
                                  if (current is TimerFinishedState) {
                                    return true;
                                  }
                                  if (previous is TimerFinishedState &&
                                      current is TimerChangedState) {
                                    return true;
                                  }
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
                                        style: AppTextStyles.light12.copyWith(
                                          color: AppColors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                AppText.aTAuthDNReceiveCodeText,
                                            style:
                                                AppTextStyles.light12.copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: AppText.aTAuthResendCodeText,
                                            style:
                                                AppTextStyles.medium12.copyWith(
                                              color: AppColors.primary,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context
                                                    .read<VerifyEmailBloc>()
                                                    .add(ResendCodeEvent(
                                                      email:
                                                          widget.response.email,
                                                    ));
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
                                      "(${state.parsedTime})",
                                      style: AppTextStyles.light12.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        AppOrangeBtn(
                          label: AppText.aTAuthVerifyEmailText,
                          isBusy: state is VerifyEmailLoadingState,
                          onTap: () {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<VerifyEmailBloc>()
                                .add(VerifyEmailTapEvent(
                                  response: widget.response,
                                  otp: pinController.text,
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}