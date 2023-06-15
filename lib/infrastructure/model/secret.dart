import 'package:flutter/material.dart';

import 'comment.dart';

class Secret {
  String key;
  String content;
  double fontSize;
  String? author;
  Color? backgroundColor;
  int likes;
  List<Comment> comments;

  Secret({
    required this.key,
    required this.content,
    required this.fontSize,
    this.likes = 0,
    this.backgroundColor = Colors.orange,
    required this.comments,
  });

  Secret.fromMap(String key, Map<dynamic, dynamic> map)
      : key = key,
        content = map['content'],
        fontSize = (map['fontSize'] is int)
            ? (map['fontSize'] as int).toDouble()
            : map['fontSize'] as double,
        author = map['author'],
        backgroundColor = map['backgroundColor'] != null
            ? Color(map['backgroundColor'])
            : null,
        likes = map['likes'],
        comments = (map['comments'] != null)
            ? List<Comment>.from(map['comments'].map((x) => Comment.fromMap(x)))
            : [];

  Map<dynamic, dynamic> toMap() {
    return {
      'content': content,
      'fontSize': fontSize,
      'author': author,
      'backgroundColor': backgroundColor?.value,
      'likes': likes,
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}
