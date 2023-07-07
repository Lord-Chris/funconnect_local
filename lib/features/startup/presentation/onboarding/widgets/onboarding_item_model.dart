import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class OnboardingItem extends Equatable {
  final Widget title;
  final String subtitle;
  final String assetPath;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.assetPath,
  });

  @override
  List<Object?> get props => [title, subtitle, assetPath];
}

final List<OnboardingItem> onboardingItems = [
  OnboardingItem(
      title: RichText(
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
      subtitle:
          "Let’s help you create memorable moments by planning your next hangout",
      assetPath: AppAssets.onboardingOnePng),
  OnboardingItem(
      title: RichText(
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
      subtitle:
          "Every place has its specialty, we ought to feel the freedom that comes with adventures",
      assetPath: AppAssets.onboardingTwoPng),
  OnboardingItem(
      title: RichText(
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
      subtitle:
          "We help you establish human connections within the context of shared experience.",
      assetPath: AppAssets.onboardingThreePng),
];
