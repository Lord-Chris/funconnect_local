import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '_constants.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.black,
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      actionsIconTheme: IconThemeData(size: 25),
      iconTheme: IconThemeData(size: 15),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,
      backgroundColor: AppColors.black,
    ),
  );
}
