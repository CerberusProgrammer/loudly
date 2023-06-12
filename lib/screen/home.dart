import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:loudly/screen/message.dart';
import 'package:loudly/screen/profile.dart';
import 'package:loudly/screen/secret.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> pages = const [
    SecretScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loudly'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        items: [
          FlashyTabBarItem(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Theme.of(context).colorScheme.primary.withAlpha(100),
            icon: const Icon(
              Icons.security,
              size: 30,
            ),
            title: const Text('Secrets'),
          ),
          FlashyTabBarItem(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Theme.of(context).colorScheme.primary.withAlpha(100),
            icon: const Icon(
              Icons.message,
              size: 30,
            ),
            title: const Text('Messages'),
          ),
          FlashyTabBarItem(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Theme.of(context).colorScheme.primary.withAlpha(100),
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
            title: const Text('Profile'),
          ),
        ],
        onItemSelected: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
