import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/authentication/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/welcome/bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/welcome/bloc/welcome_state.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/app_black_modal.dart';

class WelcomeView extends StatefulHookWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: AppBlackModalWidget(
              imageContainerHeight: 400.0,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: REdgeInsets.fromLTRB(20, 40, 20, 32),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppAssets.funconnectIconSvg,
                              height: 100.r,
                            ),
                            Spacing.vertSmall(),
                            Spacing.vertRegular(),
                            Text(
                              state.isFirstTime ? "Welcome!" : "Hello again!",
                              style: AppTextStyles.medium24.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            Spacing.vertSmall(),
                            Text(
                              state.isFirstTime
                                  ? "Continue with email ID associated with your account"
                                  : "Please enter email ID associated with your account",
                              style: AppTextStyles.dynamic(
                                14,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                weight: FontWeight.w300,
                              ),
                            ),
                            Spacing.vertExtraMedium(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => context
                                      .read<WelcomeBloc>()
                                      .add(GoogleSignInEvent()),
                                  child: CircleAvatar(
                                    backgroundColor: isDarkMode
                                        ? AppColors.white
                                        : AppColors.wGreyF1,
                                    radius: 30,
                                    child: SvgPicture.asset(
                                        AppAssets.googleIconSvg),
                                  ),
                                ),
                                if (Platform.isIOS) ...[
                                  const SizedBox(width: 16.0),
                                  GestureDetector(
                                    onTap: () => context
                                        .read<WelcomeBloc>()
                                        .add(AppleSignInEvent()),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: isDarkMode
                                          ? AppColors.white
                                          : AppColors.wGreyF1,
                                      child: SvgPicture.asset(
                                          AppAssets.appleIconSvg),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            Spacing.vertExtraMedium(),
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 0.5,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                  const SizedBox(width: 11),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      state.isFirstTime
                                          ? "Or with email ID"
                                          : "Or signin with e-mail",
                                      style: AppTextStyles.regular14.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  Expanded(
                                    child: Container(
                                      height: 0.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacing.vertExtraMedium(),
                            AppTextField(
                              label: AppText.aTAuthEmailText,
                              hint: 'johndoe@gmail.com',
                              controller: controller,
                              validator: context.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              prefix: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: SvgPicture.asset(AppAssets.emailIconSvg),
                              ),
                            ),
                            if (state.isFirstTime) const SizedBox(height: 32),
                            if (state.isFirstTime)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "By registering, you agree to our ",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground)),
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: AppTextStyles.regular14.copyWith(
                                        color: AppColors.primary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            context.read<WelcomeBloc>().add(
                                                  TandCTapEvent(),
                                                ),
                                    ),
                                    TextSpan(
                                        text: " and ",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground)),
                                    TextSpan(
                                      text: "Privacy policy",
                                      style: AppTextStyles.regular14.copyWith(
                                        color: AppColors.primary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => context
                                            .read<WelcomeBloc>()
                                            .add(PrivacyPolicyTapEvent()),
                                    ),
                                  ],
                                ),
                                // textAlign: TextAlign.center,
                                style: AppTextStyles.regular14.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppButton(
                          label: "Proceed",
                          isBusy: state is WelcomeLoadingState,
                          borderRadius: 8,
                          height: 65,
                          labelSize: 20,
                          onTap: () {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<WelcomeBloc>()
                                .add(EmailSignInEvent(email: controller.text));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
