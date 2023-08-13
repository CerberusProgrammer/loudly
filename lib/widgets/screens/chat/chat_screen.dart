import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/message_provider.dart';

class ChatScreen extends StatefulWidget {
  final String idchatRoom;

  const ChatScreen({super.key, required this.idchatRoom});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loader = context.watch<MessageProvider>().isLoading;

    return loader
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
