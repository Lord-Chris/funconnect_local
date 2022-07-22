import 'package:flutter/material.dart';
import 'package:funconnect/constants/fonts.dart';

import 'colors.dart';

class Pill extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const Pill({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.mainCardLight,
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: AppFonts.gtWalshPro,
          fontSize: 12,
          height: 1.3,
          color: AppColors.black,
        ),
      ),
    );
  }
}
