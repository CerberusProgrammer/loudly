import 'package:flutter/material.dart';

import 'comment.dart';

class Secret {
  String content;
  double fontSize;
  String? author;
  Color? backgroundColor;
  int likes;
  List<Comment>? comments;

  Secret({
    required this.content,
    required this.fontSize,
    this.likes = 0,
    this.backgroundColor = Colors.orange,
  });

  Secret.fromMap(Map<String, dynamic> map)
      : content = map['content'],
        fontSize = map['fontSize'],
        author = map['author'],
        backgroundColor = map['backgroundColor'] != null
            ? Color(map['backgroundColor'])
            : null,
        likes = map['likes'],
        comments = map['comments'] != null
            ? List<Comment>.from(map['comments'].map((x) => Comment.fromMap(x)))
            : null;

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'fontSize': fontSize,
      'author': author,
      'backgroundColor': backgroundColor?.value,
      'likes': likes,
      'comments': comments?.map((comment) => comment.toMap()).toList(),
    };
  }
}
