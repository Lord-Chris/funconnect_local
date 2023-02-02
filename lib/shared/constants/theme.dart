import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '_constants.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.black,
    useMaterial3: true,
    backgroundColor: AppColors.black,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.black),
  );
}
