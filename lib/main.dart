import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loudly/firebase_options.dart';
import 'package:loudly/providers/secret_provider.dart';
import 'package:loudly/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  final savedThemeMode = await loadThemeMode();
  runApp(
    AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (ThemeData light, ThemeData dark) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                final secretProvider = SecretProvider();
                secretProvider.syncData();
                return secretProvider;
              },
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Loudly',
            theme: light,
            darkTheme: dark,
            home: const Home(),
          ),
        );
      },
    ),
  );
}

Future<AdaptiveThemeMode?> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final themeModeString = prefs.getString('themeMode');
  if (themeModeString != null) {
    return AdaptiveThemeMode.values
        .firstWhere((e) => e.toString() == themeModeString);
  }
  return null;
}

void saveThemeMode(AdaptiveThemeMode themeMode) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('themeMode', themeMode.toString());
}
