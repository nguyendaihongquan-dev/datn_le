import 'package:flutter/material.dart';

import '../res/images/app_images.dart';
import '../theme/app_colors.dart';

class ChatDetailScreen extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Good Evening!",
      isMe: false,
      time: "8:29 pm",
    ),
    ChatMessage(
      text: "Welcome to Car2go Customer Service",
      isMe: false,
      time: "8:29 pm",
    ),
    ChatMessage(
      text: "Welcome to Car2go Customer Service",
      isMe: true,
      time: "8:29 pm",
    ),
    ChatMessage(
      text: "Welcome to Car2go Customer Service",
      isMe: false,
      time: "8:29 pm",
    ),
    ChatMessage(
      text: "Welcome to Car2go Customer Service",
      isMe: true,
      time: "Just now",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'ADMIN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          InkWell(child: Icon(Icons.add_circle_outline, color: Colors.grey[400],)),
          SizedBox(width: 12,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type your message',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 12,),
          InkWell(child: Icon(Icons.sentiment_satisfied_alt_outlined,color: Colors.grey[400])),
          SizedBox(width: 12,),
          InkWell(child: Icon(Icons.send,color: Colors.grey[400]))
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
        message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            Container(
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                      width: 1,
                      color: AppColors.primary
                  )
              ),
              padding: EdgeInsets.all(5),
              child:  Image.asset(AppImages.man,width: 24,height: 24,),
            ),
            SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: message.isMe ? Color(0xff8FE1D7) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  message.time,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}