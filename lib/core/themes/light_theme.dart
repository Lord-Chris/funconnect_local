import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  LightTheme._();

  static final theme = ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.white,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      actionsIconTheme: IconThemeData(size: 25),
      iconTheme: IconThemeData(size: 15),
    ),
    colorScheme: const ColorScheme.dark(
      onBackground: AppColors.black,
      brightness: Brightness.dark,
      primary: Colors.orange,
      background: AppColors.white,
    ),
  );
}
