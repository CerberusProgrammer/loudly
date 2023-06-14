class Comment {
  String? author;
  String content;
  int likes;

  Comment({
    this.author,
    required this.content,
    this.likes = 0,
  });

  Comment.fromMap(Map<String, dynamic> map)
      : author = map['author'],
        content = map['content'],
        likes = map['likes'];

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
      'likes': likes,
    };
  }
}
