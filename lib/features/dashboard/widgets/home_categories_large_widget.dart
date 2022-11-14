import 'package:flutter/material.dart';

import '../../../shared/constants/_constants.dart';

class HomeCategoriesLargeWidget extends StatelessWidget {
  const HomeCategoriesLargeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 170.0,
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
