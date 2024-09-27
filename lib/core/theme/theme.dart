import 'package:flutter/material.dart';

sealed class AppPalette {
  static const Color primaryColor = Color(0xFF0C54BE);
  static const Color secondaryColor = Color(0xFF303F60);
  static const Color tertiary = Color(0xFFF5F9FD);
  static const Color backgroundColor = Color(0xFFCED3DC);
}

sealed class AppThemeData {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppPalette.primaryColor,
        titleTextStyle: TextStyle(color: Colors.white)),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPalette.tertiary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      isDense: true,
      hintStyle: const TextStyle(color: Colors.black),
      fillColor: AppPalette.tertiary,
      filled: true,
      labelStyle: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
    ),
  );
}
