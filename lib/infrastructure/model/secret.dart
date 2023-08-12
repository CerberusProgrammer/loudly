import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Secret {
  String content;
  double fontSize;
  String? author;
  String? authorUid;
  Color? backgroundColor;
  int likes;
  DateTime createdAt;

  Secret({
    required this.content,
    required this.fontSize,
    this.author,
    this.authorUid,
    this.likes = 0,
    this.backgroundColor = Colors.orange,
    required this.createdAt,
  });

  Secret.fromJSON(Map<dynamic, dynamic> map)
      : content = map['content'],
        fontSize = (map['fontSize'] is int)
            ? (map['fontSize'] as int).toDouble()
            : map['fontSize'] as double,
        author = map['author'] ?? 'Anonymous',
        authorUid = map['authorUid'],
        backgroundColor = map['backgroundColor'] != null
            ? Color(
                int.parse(
                  map['backgroundColor'],
                  radix: 16,
                ),
              )
            : null,
        likes = map['likes'],
        createdAt = (map['createdAt'] as Timestamp).toDate();

  Map<String, dynamic> toJSON() {
    return {
      'content': content,
      'fontSize': fontSize,
      'author': author,
      'authorUid': authorUid,
      'backgroundColor': backgroundColor?.value,
      'likes': likes,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}
