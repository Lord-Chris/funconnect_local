import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_state.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../widgets/app_black_modal.dart';

class WelcomeView extends HookWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.black,
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              state.isFirstTime ? "Welcome!" : "Hello again!",
                              style: AppTextStyles.medium24.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              state.isFirstTime
                                  ? "Continue with your socials"
                                  : "Please enter email ID associated with your account",
                              style: AppTextStyles.dynamic(
                                14,
                                color: Colors.white,
                                weight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => context
                                      .read<WelcomeBloc>()
                                      .add(GoogleSignInEvent()),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    child: SvgPicture.asset(
                                        AppAssets.googleIconSvg),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                GestureDetector(
                                  onTap: () => context
                                      .read<WelcomeBloc>()
                                      .add(AppleSignInEvent()),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                        AppAssets.appleIconSvg),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Or with email ID",
                                    style: AppTextStyles.regular14.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const Divider(
                                  height: 5.0,
                                  thickness: 5.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            AppTextField(
                              label: AppText.aTAuthEmailText,
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
                                    const TextSpan(
                                        text:
                                            "By registering, you agree to our "),
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: AppTextStyles.regular14.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const TextSpan(text: " and "),
                                    TextSpan(
                                      text: "Privacy policy",
                                      style: AppTextStyles.regular14.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                style: AppTextStyles.regular14.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                      AppOrangeBtn(
                        label: state.isFirstTime ? "Sign Up" : "Sign In",
                        isBusy: state is WelcomeLoadingState,
                        onTap: () {
                          if (!formKey.currentState!.validate()) return;
                          context
                              .read<WelcomeBloc>()
                              .add(EmailSignInEvent(email: controller.text));
                        },
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
