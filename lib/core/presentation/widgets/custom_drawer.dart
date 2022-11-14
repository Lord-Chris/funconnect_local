import 'package:flutter/material.dart';

import '../../../shared/constants/colors.dart';

class CustomDrawer extends StatelessWidget {
  double? height;
  CustomDrawer({
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 2.0,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: AppColors.homeViewDrawerAsh),
    );
  }
}
