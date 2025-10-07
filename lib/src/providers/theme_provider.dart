import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pgoldapp/src/config/theme_config.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }

  ThemeMode getTheme() => state;
}

ThemeData get lightTheme => ThemeConfig.lightTheme;
ThemeData get darkTheme => ThemeConfig.darkTheme;
