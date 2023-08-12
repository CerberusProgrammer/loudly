import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  final User user;
  final String username;
  final int likes;
  final int posts;
  final int comments;

  /// This constructor is for users that doesn't want to
  /// add data, just want to go fast in the app.
  CustomUser.anonymous(
    this.user, {
    this.username = "john doe",
    this.likes = 0,
    this.posts = 0,
    this.comments = 0,
  });

  /// Constructor for required data in the login.
  CustomUser.login(
    this.user, {
    required this.username,
    required this.likes,
    required this.posts,
    required this.comments,
  });

  /// Constructor for required data in the create account.
  CustomUser.create(
    this.user, {
    required this.username,
    required this.likes,
    required this.posts,
    required this.comments,
  });
}
