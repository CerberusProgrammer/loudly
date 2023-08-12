import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      return Secret.fromJSON(doc.id, map);
    }).toList();

    // Notificar a los listeners que los datos han cambiado
    notifyListeners();
  }

  Future<void> uploadSecret(Secret secret) async {
    // Obtener una referencia a la colección de Secrets
    CollectionReference secretsRef =
        FirebaseFirestore.instance.collection('secrets');

    // Crear un nuevo documento Secret en Firestore
    DocumentReference secretRef = await secretsRef.add(secret.toJSON());

    // Obtener la clave del documento Secret creado
    String secretKey = secretRef.id;

    // Actualizar la clave del objeto Secret
    secret.key = secretKey;

    // Agregar el objeto Secret a la lista de secrets
    addSecret(secret);
    notifyListeners();
  }
}
