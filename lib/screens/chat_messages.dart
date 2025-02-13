import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pear_app/provider/user_provider.dart';
import 'package:pear_app/screens/message_bubble.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = context.read<UserProvider>().userModel;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text("An error occurred!"),
          );
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text("No messages found."),
          );
        }

        final loadMessages = chatSnapshots.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: false,
          itemCount: loadMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage =
                loadMessages[index].data() as Map<String, dynamic>?;
            if (chatMessage == null) {
              return const SizedBox
                  .shrink(); // Skip rendering if the message is null
            }

            final nextChatMessage = index + 1 < loadMessages.length
                ? loadMessages[index + 1].data() as Map<String, dynamic>?
                : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            // if (authenticatedUser == null) {
            //   return const Center(
            //     child: Text("User not authenticated."),
            //   );
            // }

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'] ?? '',
                isMe: authenticatedUser.email == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'] ?? '',
                username: chatMessage['username'] ?? 'Unknown',
                message: chatMessage['text'] ?? '',
                isMe: authenticatedUser.email == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
