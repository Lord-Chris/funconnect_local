import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle Whitelight = GoogleFonts.inter(color: Colors.white);

  static TextStyle WhiteMedium = GoogleFonts.inter(
      // fontFamily: VeloxFonts.markPro,
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static TextStyle WhiteBold = GoogleFonts.inter(
      // fontFamily: VeloxFonts.markPro,
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle Blacklight = GoogleFonts.inter(color: Colors.black);

  static TextStyle BlackMedium =
      GoogleFonts.inter(fontWeight: FontWeight.w500, color: Colors.black);

  static TextStyle BlackBold =
      GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle Greenlight = GoogleFonts.inter(color: AppColors.green);

  static TextStyle GreenMedium = GoogleFonts.inter(
      // fontFamily: VeloxFonts.markPro,
      fontWeight: FontWeight.w500,
      color: AppColors.green);

  static TextStyle GreenBold =
      GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.green);
}
