import 'package:flutter/material.dart';

import '../../../shared/constants/_constants.dart';

class HomeViewCategoriesSmallSubWidget extends StatelessWidget {
  const HomeViewCategoriesSmallSubWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 135,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        width: 20,
        decoration: BoxDecoration(
          color: AppColors.interestWidgetAsh,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "Art & Culture",
          style: AppTextStyle.Whitelight,
        ),
      ),
    );
  }
}
