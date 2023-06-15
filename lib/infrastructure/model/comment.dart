class Comment {
  String content;

  Comment({
    required this.content,
  });

  Comment.fromMap(Map<dynamic, dynamic> map) : content = map['content'];

  Map<dynamic, dynamic> toMap() {
    return {
      'content': content,
    };
  }
}
