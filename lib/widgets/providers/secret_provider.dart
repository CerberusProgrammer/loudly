import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loudly/infrastructure/model/custom_user.dart';

import '../../infrastructure/model/secret.dart';

class SecretProvider extends ChangeNotifier {
  List<Secret> secrets = [];

  void addSecret(Secret secret) {
    Secret newSecret = secret;
    secrets.insert(0, newSecret);
    notifyListeners();
  }

  Future<void> syncData() async {
    // Obtener una referencia a la colección de Secrets
    CollectionReference secretsRef =
        FirebaseFirestore.instance.collection('secrets');

    // Realizar una consulta para obtener los últimos 50 documentos
    QuerySnapshot querySnapshot =
        await secretsRef.orderBy('createdAt', descending: true).limit(50).get();

    // Convertir los documentos obtenidos en una lista de objetos Secret
    secrets = querySnapshot.docs.map((doc) {
      Map<dynamic, dynamic> data = doc.data() as Map<dynamic, dynamic>;
      Map<String, dynamic> map = Map<String, dynamic>.from(data);
      return Secret.fromJSON(map);
    }).toList();

    // Notificar a los listeners que los datos han cambiado
    notifyListeners();
  }

  Future<void> uploadSecret({
    required String content,
    required double fontSize,
    required Color color,
    required CustomUser user,
  }) async {
    Secret secret = Secret(
      content: content,
      createdAt: DateTime.now(),
      fontSize: fontSize,
      likes: 0,
      author: user.username,
      authorUid: user.user.uid,
      backgroundColor: color,
    );

    CollectionReference secretsRef =
        FirebaseFirestore.instance.collection('secrets');

    try {
      await secretsRef.add(secret.toJSON());
    } catch (e) {
      print('no error');
      print(e);
    }

    // Agregar el objeto Secret a la lista de secrets
    addSecret(secret);
    notifyListeners();
  }
}
