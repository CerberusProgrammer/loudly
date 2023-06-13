import 'package:flutter/material.dart';

class Secret {
  String content;
  double fontSize;
  String? author;
  Color? backgroundColor;

  Secret({
    required this.content,
    required this.fontSize,
    this.backgroundColor = Colors.orange,
  });
}
