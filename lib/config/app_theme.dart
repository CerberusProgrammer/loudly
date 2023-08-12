import 'package:flutter/material.dart';

class AppTheme {
  bool isDarkMode = false;

  ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      );
}
