import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/model/custom_user.dart';

class LoginProvider extends ChangeNotifier {
  bool successfulLogin = false;
  bool isLoged = false;
  late CustomUser userNow;

  void verifyLogedUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        isLoged = true;
        notifyListeners();
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final data = snapshot.data() as Map<String, dynamic>;

        if (data['username'] == null ||
            data['likes'] == null ||
            data['posts'] == null ||
            data['comments'] == null) {}

        userNow = CustomUser.login(
          user,
          username: data['username'],
          likes: data['likes'],
          posts: data['posts'],
          comments: data['comments'],
        );
        successfulLogin = true;
        notifyListeners();
      }
    });
  }

  Future<CustomUser?> createAccount({
    required String emailAddress,
    required String password,
    String username = "",
    bool isAnonymous = false,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      final customUser = isAnonymous
          ? CustomUser.anonymous(credential.user!)
          : CustomUser.create(
              credential.user!,
              username: username,
              likes: 0,
              posts: 0,
              comments: 0,
            );
      userNow = customUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(customUser.user.uid)
          .set(
        {
          'username': customUser.username,
          'email': emailAddress,
          'likes': customUser.likes,
          'posts': customUser.posts,
          'comments': customUser.comments,
        },
      );

      return customUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> loginAccount(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      final data = snapshot.data() as Map<String, dynamic>;

      if (data['email'] != emailAddress) {
        throw Exception('El correo electrónico no coincide.');
      }

      if (data['username'] == null ||
          data['likes'] == null ||
          data['posts'] == null ||
          data['comments'] == null) {}

      final customUser = CustomUser.login(
        credential.user!,
        username: data['username'],
        likes: data['likes'],
        posts: data['posts'],
        comments: data['comments'],
      );

      userNow = customUser;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }
    return false;
  }
}
