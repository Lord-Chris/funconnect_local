import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/app_orange_button.dart';
import '../../../../shared/components/video_player_widget.dart';

class OnboardingView extends StatefulHookWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final titles = <Widget>[
    RichText(
      key: const ValueKey(1),
      textAlign: TextAlign.center,
      textScaleFactor: 1,
      text: TextSpan(
        text: 'Create ',
        style: AppTextStyles.bold36.copyWith(
          color: AppColors.white,
        ),
        children: [
          TextSpan(
            text: 'events ',
            style: AppTextStyles.bold36.copyWith(
              color: AppColors.primary,
            ),
          ),
          TextSpan(
            text: 'for meet-ups',
            style: AppTextStyles.bold36.copyWith(
              color: AppColors.white,
            ),
          )
        ],
      ),
    ),
    RichText(
      key: const ValueKey(2),
      textAlign: TextAlign.center,
      textScaleFactor: 1,
      text: TextSpan(
        text: 'Explore ',
        style: AppTextStyles.bold36.copyWith(
          color: AppColors.primary,
        ),
        children: [
          TextSpan(
            text: 'amazing places near you ',
            style: AppTextStyles.bold36.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    ),
    RichText(
      key: const ValueKey(3),
      textAlign: TextAlign.center,
      textScaleFactor: 1,
      text: TextSpan(
        text: 'Share your best',
        style: AppTextStyles.bold36.copyWith(
          color: AppColors.white,
        ),
        children: [
          TextSpan(
            text: ' experiences',
            style: AppTextStyles.bold36.copyWith(
              color: AppColors.primary,
            ),
          )
        ],
      ),
    ),
  ];

  final subtitles = <Widget>[
    Text(
      "Let’s help you create memorable moments by planning your next hangout",
      textAlign: TextAlign.center,
      style: AppTextStyles.regular16.copyWith(
        color: AppColors.white,
      ),
    ),
    Text(
      "Every place has its specialty, we ought to feel the freedom that comes with adventures",
      textAlign: TextAlign.center,
      style: AppTextStyles.regular16.copyWith(
        color: AppColors.white,
      ),
    ),
    Text(
      "We help you establish human connections within the context of shared experience.",
      textAlign: TextAlign.center,
      style: AppTextStyles.regular16.copyWith(
        color: AppColors.white,
      ),
    ),
  ];

  final controller = PageController(initialPage: 0);
  static const int delay = 5;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: delay), (timer) {
      if (controller.hasClients) {
        int page = ((controller.page ?? 0) + 1).toInt();
        if (page < 3) {
          controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } else {
          controller.jumpToPage(0);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    timer?.cancel();
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
                    children: List.filled(3, false).map((e) {
                      return const VideoPlayerWidget();
                    }).toList(),
                  ),
                ),
                Positioned.fill(
                    child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black,
                        AppColors.transparent,
                        AppColors.transparent,
                        AppColors.black,
                      ],
                      stops: [0.1, 0.3, 0.6, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.clamp,
                    ),
                  ),
                )),
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 40.0,
                        ),
                        child: HookBuilder(builder: (context) {
                          final anim = useAnimationController(
                              duration: const Duration(seconds: delay));
                          anim.repeat();
                          final value = useAnimation(
                              Tween<double>(begin: 0, end: 1).animate(anim));
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: LinearProgressIndicator(
                                    value: state.page > 0 ? 1 : value,
                                    color: AppColors.primary,
                                    backgroundColor: AppColors.white,
                                    minHeight: 4,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: LinearProgressIndicator(
                                    value: state.page < 1
                                        ? 0
                                        : state.page > 1
                                            ? 1
                                            : value,
                                    color: AppColors.primary,
                                    backgroundColor: AppColors.white,
                                    minHeight: 4,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: LinearProgressIndicator(
                                    value: state.page < 2 ? 0 : value,
                                    color: AppColors.primary,
                                    backgroundColor: AppColors.white,
                                    minHeight: 4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: titles[state.page],
                            ),
                            Spacing.vertRegular(),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: subtitles[state.page],
                            ),
                          ],
                        ),
                      ),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
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
          );
        },
      ),
    );
  }
}
