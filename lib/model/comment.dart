class Comment {
  String author;
  String content;
  int likes;

  Comment({
    required this.author,
    required this.content,
    this.likes = 0,
  });
}
