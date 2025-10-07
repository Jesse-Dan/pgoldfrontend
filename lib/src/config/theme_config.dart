import 'package:flutter/material.dart';

import 'color_config.dart';

class ThemeConfig {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorConfig.primaryBlueLight,
    colorScheme: const ColorScheme.light(
      primary: ColorConfig.primaryBlueLight,
      secondary: ColorConfig.primaryBlueDark,
      tertiary: ColorConfig.accentYellow,
      surface: ColorConfig.surfaceWhite,
      background: ColorConfig.backgroundLightGrey,
      onPrimary: ColorConfig.textWhite,
      onSurface: ColorConfig.textDark,
    ),
    scaffoldBackgroundColor: ColorConfig.surfaceWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConfig.primaryBlueDark,
      foregroundColor: ColorConfig.textWhite,
      elevation: 0,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConfig.primaryBlueLight,
      selectedItemColor: ColorConfig.surfaceWhite,
      unselectedItemColor: ColorConfig.textGrey,
      type: BottomNavigationBarType.fixed,
      elevation: 5,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConfig.primaryBlueLight,
        foregroundColor: ColorConfig.surfaceWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 1,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(6),
        backgroundColor: ColorConfig.surfaceWhite,
        foregroundColor: ColorConfig.primaryBlueLight,
        side: const BorderSide(color: ColorConfig.primaryBlueLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 1,
      ),
    ),

    // ✅ Checkbox theme for Light Mode
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: const BorderSide(color: ColorConfig.textGrey, width: 1.2),
      checkColor: WidgetStateProperty.all(ColorConfig.textWhite),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConfig.primaryBlueDark;
        }
        return ColorConfig.surfaceWhite;
      }),
      overlayColor: WidgetStateProperty.all(
          ColorConfig.primaryBlueLight.withOpacity(0.2)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorConfig.primaryBlueLight,
    colorScheme: ColorScheme.dark(
      primary: ColorConfig.primaryBlueLight,
      secondary: ColorConfig.accentYellow,
      tertiary: ColorConfig.primaryBlueDark,
      surface: const Color(0xFF2C2C2C),
      background: const Color(0xFF121212),
      onPrimary: ColorConfig.textWhite,
      onSurface: ColorConfig.textWhite,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConfig.primaryBlueDark,
      foregroundColor: ColorConfig.textWhite,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: ColorConfig.textWhite),
      titleMedium: TextStyle(color: ColorConfig.textWhite),
      bodyMedium: TextStyle(color: ColorConfig.textGrey),
      labelLarge: TextStyle(color: ColorConfig.textWhite),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: ColorConfig.primaryBlueLight,
      unselectedItemColor: ColorConfig.textGrey,
      type: BottomNavigationBarType.fixed,
      elevation: 5,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF404040),
        foregroundColor: ColorConfig.primaryBlueLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 1,
      ),
    ),

    // ✅ Checkbox theme for Dark Mode
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: const BorderSide(color: ColorConfig.textGrey, width: 1.2),
      checkColor: WidgetStateProperty.all(ColorConfig.textWhite),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConfig.primaryBlueLight;
        }
        return const Color(0xFF2C2C2C);
      }),
      overlayColor: WidgetStateProperty.all(
          ColorConfig.primaryBlueLight.withOpacity(0.3)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
