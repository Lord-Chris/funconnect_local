import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/constants/app_textStyle.dart';
import '../../../../shared/constants/colors.dart';

class InterestSelectionWidget extends StatelessWidget {
  const InterestSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 65,
        width: 185,
        decoration: BoxDecoration(
          color: AppColors.interestWidgetAsh,
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(),
            Text(
              "Fine dining\nRestaurant",
              style: AppTextStyle.Whitelight,
            ),
            Checkbox(
              value: false,
              onChanged: (String) {},
              shape: const CircleBorder(),
            )
          ],
        ),
      ),
    );
  }
}
