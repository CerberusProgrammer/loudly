import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loudly/widgets/providers/message_provider.dart';
import 'package:provider/provider.dart';

import 'package:loudly/config/app_theme.dart';
import 'package:loudly/firebase_options.dart';
import 'package:loudly/widgets/providers/login_provider.dart';
import 'package:loudly/widgets/providers/secret_provider.dart';
import 'package:loudly/widgets/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final secretProvider = SecretProvider();
            secretProvider.syncData();
            return secretProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final loginProvider = LoginProvider();
            return loginProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loudly',
        theme: AppTheme().appTheme,
        home: const LoginScreen(),
      ),
    );
  }
}
