import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/constants/colors.dart';

class AppOrangeBtn extends StatelessWidget {
  final String label;
  final double? height;
  final double? weight;
  final VoidCallback? onTap;

  const AppOrangeBtn({
    Key? key,
    required this.label,
    this.height,
    this.weight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.inter(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }
}
