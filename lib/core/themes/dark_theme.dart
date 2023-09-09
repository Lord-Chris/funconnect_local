import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      toolbarHeight: 0,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColors.black,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      onBackground: AppColors.white,
      brightness: Brightness.dark,
      primary: Colors.orange,
      background: AppColors.black,
    ),
  );
}
