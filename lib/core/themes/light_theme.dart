import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  DarkTheme._();

  static final theme = ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.black,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      actionsIconTheme: IconThemeData(size: 25),
      iconTheme: IconThemeData(size: 15),
    ),
    colorScheme: const ColorScheme.light(
      onBackground: AppColors.black,
      brightness: Brightness.light,
      primary: Colors.orange,
      background: AppColors.black,
    ),
  );
}
