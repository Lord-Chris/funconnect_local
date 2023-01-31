import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_spacer.dart';
import '../../../../shared/constants/_constants.dart';

class HomeInterestWidget extends StatelessWidget {
  const HomeInterestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: AppColors.interestWidgetAsh,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(
              radius: 10,
            ),
            Spacing.horizSmall(),
            Text(
              "Fine dining",
              maxLines: 1,
              style: AppTextStyles.regular12,
            ),
          ],
        ),
      ),
    );
  }
}
