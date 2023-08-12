import 'package:flutter/material.dart';
import 'package:loudly/widgets/providers/login_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Card(
              child: Row(
                children: [
                  Text(context.watch<LoginProvider>().userNow.user.email!),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Dark Theme',
              style: TextStyle(),
            ),
            trailing: Switch(
              onChanged: (bool value) {},
              value: true,
            ),
          )
        ],
      ),
    );
  }
}
