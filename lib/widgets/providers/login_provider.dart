import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/model/custom_user.dart';

class LoginProvider extends ChangeNotifier {
  bool successfulLogin = false;
  String status = "process";
  late CustomUser userNow;

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
        status = 'La contraseña proporcionada es demasiado débil.';
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        status = 'Ya existe una cuenta para ese correo electronico';
        notifyListeners();
      }
    } catch (e) {
      status = e.toString();
      notifyListeners();
    }
    return null;
  }

  Future<CustomUser?> loginAccount(
    String emailAddress,
    String password,
  ) async {
    try {
      status = 'Losfsfsfs.';
      notifyListeners();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      final data = snapshot.data() as Map<String, dynamic>;

      // Verificar que el correo electrónico es correcto
      if (data['email'] != emailAddress) {
        status = 'El correo electrónico no coincide.';
        notifyListeners();
        throw Exception('El correo electrónico no coincide.');
      }

      // Verificar que los datos importados son válidos
      if (data['username'] == null ||
          data['likes'] == null ||
          data['posts'] == null ||
          data['comments'] == null) {
        status = 'Los datos importados no son válidos.';
        notifyListeners();
      }

      final customUser = CustomUser.login(
        credential.user!,
        username: data['username'],
        likes: data['likes'],
        posts: data['posts'],
        comments: data['comments'],
      );

      notifyListeners();
      successfulLogin = true;
      userNow = customUser;
      return customUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        status = 'No se encontró ningún usuario para ese correo electrónico.';
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        status = 'Contraseña incorrecta proporcionada para ese usuario.';
        notifyListeners();
      }
    }
    return null;
  }
}
