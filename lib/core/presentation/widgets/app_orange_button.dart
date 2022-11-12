import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/constants/colors.dart';

class App_Orange_Btn extends StatelessWidget {
  String label;
  double? height;
  double? weight;

  App_Orange_Btn({
    required this.label,
    this.height,
    this.weight,
    Key? key,
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
        onPressed: () {},
        child: Text(
          label,
          style: GoogleFonts.inter(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }
}
