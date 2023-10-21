import 'package:depo_app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@Deprecated('Use DarkTheme or LightTheme instead')
class AppTheme{

  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.magnolia,
    dividerColor: Colors.black26,

    appBarTheme: AppBarTheme(
      color: AppColors.delftBlue,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      )
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.delftBlue,
      onPrimary: Colors.white,
      primaryContainer: Colors.black12,
      secondary: AppColors.powderBlue,
      onSecondary: Colors.black,
      secondaryContainer: Colors.black38,
      tertiary: AppColors.darkMossGreen,
      tertiaryContainer: Colors.black26,
      background: AppColors.magnolia,
      error: AppColors.madder,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.magnolia,
    ),

    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
      selectedColor: AppColors.raisinBlack,
      selectedTileColor: AppColors.transparentPowderBlue,
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.delftBlue,
      contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16
      ),
      showCloseIcon: true
    ),
  );

  static final ThemeData dark = ThemeData(

      scaffoldBackgroundColor: AppColors.raisinBlack,
      dividerColor: Colors.black26,

      appBarTheme: AppBarTheme(
          color: AppColors.delftBlue,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )
      ),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.powderBlue,
        onPrimary: Colors.white,
        primaryContainer: AppColors.spaceCadet,
        secondary: AppColors.powderBlue,
        onSecondary: Colors.white,
        secondaryContainer: Colors.black38,
        tertiary: AppColors.pistachio,
        tertiaryContainer: Colors.black26,
        background: AppColors.magnolia,
        error: AppColors.pantone,
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.raisinBlack,
      ),

      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
        selectedColor: Colors.white,
        selectedTileColor: AppColors.transparentPowderBlue,
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.delftBlue,
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
        showCloseIcon: true
      )
  );
}