import 'package:flutter/material.dart';

class DarkTheme{

  static const textColor = Color(0xFFffffff);
  static const backgroundColor = Color(0xFF0b1223);
  static const primaryColor = Color(0xFFa18636);
  static const primaryFgColor = Color(0xFF0b1223);
  static const secondaryColor = Color(0xFF131d39);
  static const secondaryFgColor = Color(0xFFffffff);
  static const accentColor = Color(0xFFc6a953);
  static const accentFgColor = Color(0xFF0b1223);

  static final colorScheme = ColorScheme.dark(
    background: backgroundColor,
    onBackground: textColor,
    primary: primaryColor,
    onPrimary: primaryFgColor,
    secondary: secondaryColor,
    onSecondary: secondaryFgColor,
    tertiary: accentColor,
    onTertiary: accentFgColor,
    surface: backgroundColor,
    onSurface: textColor,
    error: Brightness.dark == Brightness.light ? const Color(0xffB3261E) : const Color(0xffF2B8B5),
    onError: Brightness.dark == Brightness.light ? const Color(0xffFFFFFF) : const Color(0xff601410),
  );

  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    cardColor: secondaryColor,

    colorScheme: colorScheme,

    drawerTheme: const DrawerThemeData(
      backgroundColor: backgroundColor
    ),
  );
}