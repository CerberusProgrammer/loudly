class Comment {
  String key;
  String content;
  String? author;
  String? authorUid;
  DateTime createdAt;
  String secretKey;

  Comment({
    required this.key,
    required this.content,
    this.author,
    this.authorUid,
    required this.createdAt,
    required this.secretKey,
  });

  Comment.fromMap(this.key, Map<dynamic, dynamic> map)
      : content = map['content'],
        author = map['author'] ?? 'Anonymous',
        authorUid = map['authorUid'],
        createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        secretKey = map['secretKey'];

  Map<dynamic, dynamic> toMap() {
    return {
      'content': content,
      'author': author,
      'authorUid': authorUid,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'secretKey': secretKey,
    };
  }
}
