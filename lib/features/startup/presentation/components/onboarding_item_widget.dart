import 'package:flutter/material.dart';
import 'package:funconnect/features/startup/presentation/domain/entities/onboarding_item_model.dart';

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
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: onboardingItem.title,
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              onboardingItem.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
