import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../infrastructure/model/secret.dart';

class DisplaySecret extends StatelessWidget {
  final Secret secret;

  const DisplaySecret({super.key, required this.secret});

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
                          style: TextStyle(fontSize: secret.fontSize),
                        ),
                        Text('by ${secret.author}'),
                        const Spacer(),
                      ],
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
                            size: 40,
                          );
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.comment,
                          size: 40,
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
