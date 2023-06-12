import 'package:flutter/material.dart';

class Secret {
  String content;
  String? author;
  Color? backgroundColor;

  Secret({
    required this.content,
    this.backgroundColor,
  });
}
