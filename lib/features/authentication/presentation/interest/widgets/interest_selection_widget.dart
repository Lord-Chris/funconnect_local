import 'package:flutter/material.dart';

import '../../../../../shared/components/_components.dart';
import '../../../../../shared/constants/_constants.dart';

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
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.wGreyF1
            : AppColors.interestWidgetAsh,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppNetworkImage(
            url: image,
            isCircular: true,
            fit: BoxFit.cover,
            placeholderAssetImage: AppAssets.placesPlaceHolderSvg,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.regular12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: onSelected,
            shape: const CircleBorder(),
            activeColor: AppColors.primary,
            visualDensity: VisualDensity.compact,
          )
        ],
      ),
    );
  }
}
