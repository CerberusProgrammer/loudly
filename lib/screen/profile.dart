import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((themeMode) {
      setState(() {
        isDarkMode = themeMode == AdaptiveThemeMode.dark;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 200,
            child: Card(
              child: Row(
                children: [],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Dark Theme',
              style: TextStyle(),
            ),
            trailing: Switch(
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
                final themeMode =
                    value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;
                AdaptiveTheme.of(context).setThemeMode(themeMode);
                saveThemeMode(themeMode);
              },
              value: isDarkMode,
            ),
          )
        ],
      ),
    );
  }
}
