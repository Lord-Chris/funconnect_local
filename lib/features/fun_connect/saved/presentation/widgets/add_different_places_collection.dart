import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/app_spacer.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class AddPlacesCollection extends StatelessWidget {
  final String text;
  const AddPlacesCollection({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(71),
        border: Border.all(
          color: AppColors.white,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.add),
          Spacing.horizSmall(),
          Text(
            text,
            style: AppTextStyles.medium10.copyWith(color: AppColors.gray97),
          ),
        ],
      ),
    );
  }
}
