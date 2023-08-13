import 'package:flutter/material.dart';
import 'package:loudly/widgets/providers/login_provider.dart';
import 'package:loudly/widgets/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/message_provider.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoginProvider>().userNow;

    return ListView.builder(
      itemCount: user.chatRooms.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              context
                  .watch<MessageProvider>()
                  .syncChatRoom(user.chatRooms[index]);
              return ChatScreen(
                idchatRoom: user.chatRooms[index],
              );
            }));
          },
          title: Text(
            user.chatRooms[index],
          ),
        );
      },
    );
  }
}
