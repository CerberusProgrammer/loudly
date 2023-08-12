import 'package:flutter/material.dart';
import 'package:loudly/infrastructure/model/secret.dart';

class PostSecret extends StatelessWidget {
  final Secret secret;

  const PostSecret({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
