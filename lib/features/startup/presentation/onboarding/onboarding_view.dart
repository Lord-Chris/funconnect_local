import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/startup/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:funconnect/features/startup/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:funconnect/features/startup/presentation/onboarding/widgets/onboarding_item_model.dart';
import 'package:funconnect/features/startup/presentation/onboarding/widgets/onboarding_item_widget.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:story_view/story_view.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyViewController = StoryController();
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Expanded(
            child: StoryView(
              controller: storyViewController,
              indicatorColor: AppColors.primary,
              repeat: true,
              storyItems: onboardingItems
                  .map((e) => StoryItem(
                        OnboardingItemWidget(onboardingItem: e),
                        duration: const Duration(seconds: 5),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 32),
          BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppButton(
                  label: "Get Started",
                  borderRadius: 8,
                  height: 65,
                  labelSize: 20,
                  onTap: () =>
                      context.read<OnboardingBloc>().add(GetStartedEvent()),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
