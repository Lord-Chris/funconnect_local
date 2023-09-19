import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      toolbarHeight: 0,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColors.white,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
    ),
    colorScheme: const ColorScheme.light(
      onBackground: AppColors.black,
      brightness: Brightness.light,
      primary: Colors.orange,
      background: AppColors.white,
    ),
  );
}
