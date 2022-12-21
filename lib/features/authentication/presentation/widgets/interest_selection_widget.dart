import 'package:flutter/material.dart';

import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/textstyles.dart';

class InterestSelectionWidget extends StatelessWidget {
  final bool isSelected;
  final void Function(bool?)? onSelected;
  final String title;
  final String image;
  const InterestSelectionWidget({
    Key? key,
    required this.isSelected,
    this.onSelected,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.interestWidgetAsh,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CircleAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.regular12,
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: onSelected,
            shape: const CircleBorder(),
            visualDensity: VisualDensity.compact,
          )
        ],
      ),
    );
  }
}
