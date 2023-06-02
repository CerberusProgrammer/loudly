import 'package:loudly/model/secret.dart';

import 'comment.dart';

class Post {
  int likes;
  Secret secret;
  List<Comment>? comments;

  Post({
    this.likes = 0,
    required this.secret,
    this.comments,
  });
}
