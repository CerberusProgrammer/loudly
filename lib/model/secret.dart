import 'package:flutter/material.dart';

class Secret {
  String title;
  String subtitle;
  String content;
  String? author;
  Image? backgroundImage;
  Color? backgroundColor;
  IconData? backgroundIcon;

  Secret({
    required this.title,
    this.subtitle = "",
    required this.content,
  });
}
