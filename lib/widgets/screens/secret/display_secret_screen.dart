import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../infrastructure/model/secret.dart';

class DisplaySecretScreen extends StatelessWidget {
  final Secret secret;

  const DisplaySecretScreen({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Card(
                    color: secret.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            secret.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: secret.fontSize,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                          Text(
                            'by ${secret.author}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      LikeButton(
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.thumb_up,
                            color:
                                isLiked ? secret.backgroundColor : Colors.grey,
                            size: 36,
                          );
                        },
                      ),
                      const Spacer(),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.message,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
