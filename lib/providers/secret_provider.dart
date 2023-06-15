import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../infrastructure/model/secret.dart';

class SecretProvider extends ChangeNotifier {
  List<Secret> secrets = [];

  void addSecret(Secret secret) {
    Secret newSecret = secret;
    secrets.add(newSecret);
    notifyListeners();
  }

  Future<void> syncData() async {
    DatabaseReference itemRef =
        FirebaseDatabase.instance.ref().child('secrets');

    await itemRef.once().then((DatabaseEvent event) {
      secrets.clear();
      if (event.snapshot.value is Map) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;

        values.forEach((key, values) {
          if (values is Map<dynamic, dynamic>) {
            secrets.add(Secret.fromMap(values));
          }
        });
        notifyListeners();
      }
    });
  }
}
