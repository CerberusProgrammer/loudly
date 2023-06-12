import 'package:loudly/model/secret.dart';

import 'comment.dart';

class Post {
  int views;
  Secret secret;
  List<Comment>? comments;

  Post({
    this.views = 0,
    required this.secret,
    this.comments,
  });
}
