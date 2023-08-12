import 'package:flutter/material.dart';

class AppTheme {
  bool isDarkMode = false;

  ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 76, 22, 168),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      );
}
