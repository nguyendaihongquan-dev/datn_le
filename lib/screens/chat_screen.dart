import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';

import '../theme/app_colors.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage(name: 'ADMIN', message: 'Chào cả lớp !', time: '9:40 AM', className: '',avatar: AppImages.man),
    ChatMessage(name: 'Nguyễn Ngọc Minh', message: 'Chào cả lớp !', time: '9:40 AM', className: '3A',avatar: AppImages.man),
    ChatMessage(name: 'Bùi Thị Lê', message: 'Chào cả lớp !', time: '9:40 AM', className: '4B',avatar: AppImages.man),
    ChatMessage(name: 'Lê Văn Tường', message: 'Chào cả lớp !', time: '9:40 AM', className: '5C',avatar: AppImages.man),
    ChatMessage(name: 'Nguyễn Việt Thắng', message: 'Chào cả lớp !', time: '9:40 AM', className: '4B',avatar: AppImages.man),
    ChatMessage(name: 'Nguyễn Đ. Hồng Quân', message: 'Chào cả lớp !', time: '9:40 AM', className: '5D',avatar: AppImages.man),
    ChatMessage(name: 'Đỗ Vũ Tùng Lâm', message: 'Chào cả lớp !', time: '9:40 AM', className: '3B',avatar: AppImages.man),
    ChatMessage(name: 'Trịnh Đức Chung', message: 'Chào cả lớp !', time: '9:40 AM', className: '3C',avatar: AppImages.man),
    ChatMessage(name: 'Trần Trọng Quyền', message: 'Chào cả lớp !', time: '9:40 AM', className: '4B',avatar: AppImages.man),
  ];

   ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                  prefixIcon: Icon(Icons.manage_search_rounded, color: Colors.grey[400],size: 26,),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero
                ),
              ),
            ),
            // Chat List
            Expanded(
              child: ListView.separated(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatListItem(message: messages[index]);
                }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 8,) ;},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String name;
  final String message;
  final String time;
  final String className;
  final String avatar;

  ChatMessage({
    required this.name,
    required this.message,
    required this.time,
    required this.className,
    required this.avatar,
  });
}

class ChatListItem extends StatelessWidget {
  final ChatMessage message;

  const ChatListItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>    ChatDetailScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Avatar
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
              child:  Image.asset(message.avatar,width: 24,height: 24,),
            ),
            SizedBox(width: 12),
            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        message.name == 'ADMIN'
                            ? 'ADMIN'
                            : 'PH ${message.name} ${message.className}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'You: ${message.message}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Time
            Text(
              message.time,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}