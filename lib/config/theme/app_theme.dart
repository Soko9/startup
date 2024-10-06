import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/values/app_colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accentBlue,
          tertiary: AppColors.accentPurple,
          surfaceContainer: AppColors.container,
        ),
        scaffoldBackgroundColor: AppColors.scaffold,
        textTheme: GoogleFonts.barlowSemiCondensedTextTheme(
          Typography.blackCupertino,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primary,
        ),
      );

  static ThemeData get darktheme => ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDark,
          secondary: AppColors.accentBlueDark,
          tertiary: AppColors.accentPurpleDark,
          surfaceContainer: AppColors.containerDark,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldDark,
        textTheme: GoogleFonts.barlowSemiCondensedTextTheme(
          Typography.whiteCupertino,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primaryDark,
        ),
      );
}
