import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get bold36 => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.11,
      );

  static TextStyle get bold28 => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.43,
      );

  static TextStyle get bold24 => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.33,
      );

  static TextStyle get bold20 => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.4,
      );

  static TextStyle get bold18 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.33,
      );

  static TextStyle get bold16 => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.5,
      );

  // Medium
  static TextStyle get medium24 => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  static TextStyle get medium20 => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  static TextStyle get medium16 => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  static TextStyle get medium14 => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.14,
      );

  static TextStyle get medium12 => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  static TextStyle get medium10 => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.6,
      );

  // Regular
  static TextStyle get regular24 => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        height: 1.33,
      );

  static TextStyle get regular20 => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        height: 1.2,
      );

  static TextStyle get regular16 => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get regular14 => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.14,
      );

  static TextStyle get regular12 => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.33,
      );

  static TextStyle get regular10 => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        height: 1.6,
      );

  static TextStyle whiteMedium = GoogleFonts.inter(
      // fontFamily: VeloxFonts.markPro,
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static TextStyle whiteBold = GoogleFonts.inter(
      // fontFamily: VeloxFonts.markPro,
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle whitelight = GoogleFonts.inter(color: Colors.white);

  static TextStyle blacklight = GoogleFonts.inter(color: Colors.black);

  static TextStyle blackMedium =
      GoogleFonts.inter(fontWeight: FontWeight.w500, color: Colors.black);

  static TextStyle blackBold =
      GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black);
}
