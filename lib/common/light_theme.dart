import 'package:flutter/material.dart';

class LightTheme{

  static const textColor = Color(0xFF000000);
  static const backgroundColor = Color(0xFFdce3f4);
  static const primaryColor = Color(0xFFc9af5e);
  static const primaryFgColor = Color(0xFF000000);
  static const secondaryColor = Color(0xFFc6d0ec);
  static const secondaryFgColor = Color(0xFF000000);
  static const accentColor = Color(0xFFac8f39);
  static const accentFgColor = Color(0xFF000000);

  static final colorScheme = ColorScheme.light(
    brightness: Brightness.light,
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
    error: Brightness.light == Brightness.light ? const Color(0xffB3261E) : const Color(0xffF2B8B5),
    onError: Brightness.light == Brightness.light ? const Color(0xffFFFFFF) : const Color(0xff601410),
  );

  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: colorScheme,

    drawerTheme: const DrawerThemeData(
        backgroundColor: backgroundColor
    ),

  );

}
