import 'package:flutter/material.dart';

import '../infrastructure/model/secret.dart';
import 'display_secret.dart';

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
            return const DisplaySecret();
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
                  style: TextStyle(
                    fontSize: secret.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_sharp,
                    size: 30,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withAlpha(180),
                  ),
                  Text(
                    ' 10',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha(180),
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.message,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withAlpha(180),
                    size: 30,
                  ),
                  Text(
                    ' 10',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha(180),
                    ),
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
