import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pear_app/screens/chat_messages.dart';
import 'package:pear_app/screens/new_messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.getToken();
    fcm.subscribeToTopic("chat");
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Nhóm chat chung",
        ),
        leading: Container(),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // FirebaseAuth.instance.signOut();
        //     },
        //     icon: Icon(
        //       Icons.exit_to_app,
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //   )
        // ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
