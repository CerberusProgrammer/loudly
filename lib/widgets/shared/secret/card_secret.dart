import 'package:flutter/material.dart';

import '../../../infrastructure/model/secret.dart';
import '../../screens/secret/display_secret_screen.dart';

class CardSecret extends StatelessWidget {
  final Secret secret;

  const CardSecret({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return DisplaySecretScreen(
              secret: secret,
            );
          }));
        },
        child: Column(
          children: [
            Expanded(
                child: Card(
              color: secret.backgroundColor,
              child: Center(
                child: Text(
                  secret.content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: secret.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 20,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withAlpha(180),
                  ),
                  Text(
                    ' ${secret.likes}',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.message,
                    color: Colors.black.withOpacity(0.6),
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
