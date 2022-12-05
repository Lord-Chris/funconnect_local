import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/presentation/widgets/core_widgets.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../models/onBoarding_carousel_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state is! OnboardingInitialState) return const SizedBox();
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: PageView(
                    onPageChanged: (val) => context
                        .read<OnboardingBloc>()
                        .add(PageChangedEvent(page: val)),
                    controller: controller,
                    physics: const ClampingScrollPhysics(),
                    children: onBoardingCarouselItems.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(e.ImgUrl), fit: BoxFit.cover),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.black,
                              AppColors.black,
                            ],
                            stops: [0.02, 0.4],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.black,
                            AppColors.transparent,
                          ],
                          stops: [0.4, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 40.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: AppColors.primary,
                                  thickness: 4,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Divider(
                                  color: state.page > 0
                                      ? AppColors.primary
                                      : AppColors.white,
                                  thickness: 4,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Divider(
                                  color: state.page == 2
                                      ? AppColors.primary
                                      : AppColors.white,
                                  thickness: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.black,
                            AppColors.transparent,
                          ],
                          stops: [0.4, 1],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Create events for meet-ups",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 36,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              AppSpacer.xtraHeightSpace,
                              Text(
                                "Let’s help you create memorable moments by planning your next hangout",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          AppSpacer.xtraHeightSpace,
                          AppSpacer.xtraHeightSpace,
                          AppOrangeBtn(
                            label: "Get Started",
                            onTap: () => context
                                .read<OnboardingBloc>()
                                .add(GetStartedEvent()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
