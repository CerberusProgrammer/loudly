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
            child: Card(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.watch<LoginProvider>().userNow.username),
                      Text(
                          'Likes: ${context.watch<LoginProvider>().userNow.likes}'),
                      Text(
                          'Comments: ${context.watch<LoginProvider>().userNow.comments}'),
                      Text(
                          'Posts: ${context.watch<LoginProvider>().userNow.posts}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
