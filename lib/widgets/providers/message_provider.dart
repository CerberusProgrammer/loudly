import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loudly/infrastructure/model/message.dart';

class MessageProvider extends ChangeNotifier {
  late List<String> chats;
  late List<Message> chat;
  bool isLoading = false;

  void syncChatRoom(String idchatRoom) async {
    isLoading = true;
    final snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(idchatRoom)
        .get();

    final data = snapshot.data() as Map<String, dynamic>;

    // Obtener la lista de mensajes
    List<dynamic> messages = List.from(data['messages']);

    // Procesar cada mensaje individualmente
    for (Map<String, dynamic> messageData in messages) {
      // Obtener información sobre el mensaje
      String authorId = messageData['authorId'];
      String message = messageData['message'];
      Timestamp time = messageData['time'];

      Message messageObj = Message(
        authorId: authorId,
        message: message,
        time: time.toDate(),
      );

      chat.add(messageObj);
    }

    isLoading = false;
    notifyListeners();
  }
}
