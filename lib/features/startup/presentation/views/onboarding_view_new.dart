import 'package:flutter/material.dart';
import 'package:funconnect/features/startup/presentation/components/onboarding_item_widget.dart';
import 'package:funconnect/features/startup/presentation/domain/entities/onboarding_item_model.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:story_view/story_view.dart';

class OnboardingViewNew extends StatelessWidget {
  const OnboardingViewNew({super.key});

  @override
  Widget build(BuildContext context) {
    final storyViewController = StoryController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: StoryView(
            controller: storyViewController,
            indicatorColor: AppColors.primary,
            storyItems: [
              StoryItem(
                  OnboardingItemWidget(
                    onboardingItem: onboardingItems[0],
                  ),
                  duration: const Duration(seconds: 5)),
              StoryItem(
                  OnboardingItemWidget(
                    onboardingItem: onboardingItems[1],
                  ),
                  duration: const Duration(seconds: 5)),
              StoryItem(
                  OnboardingItemWidget(
                    onboardingItem: onboardingItems[2],
                  ),
                  duration: const Duration(seconds: 5)),
            ],
          ))
        ],
      ),
    );
  }
}
