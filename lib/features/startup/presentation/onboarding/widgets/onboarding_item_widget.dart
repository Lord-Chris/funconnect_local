import 'package:flutter/material.dart';
import 'package:funconnect/features/startup/presentation/onboarding/widgets/onboarding_item_model.dart';
import 'package:funconnect/shared/constants/colors.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem onboardingItem;
  const OnboardingItemWidget({super.key, required this.onboardingItem});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          onboardingItem.assetPath,
          fit: BoxFit.cover,
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
          ),
        ),
        Positioned.fill(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: onboardingItem.title,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                onboardingItem.subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
      ],
    );
  }
}
