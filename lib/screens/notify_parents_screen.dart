import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pear_app/model/notify_model.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/screens/test_screen.dart';
import 'package:pear_app/theme/app_colors.dart';
import 'create_notify_screen.dart';
import 'detail_notify_screen.dart';

class NotificationParentsScreen extends StatefulWidget {
  const NotificationParentsScreen({super.key});

  @override
  State<NotificationParentsScreen> createState() =>
      _NotificationParentsScreenState();
}

class _NotificationParentsScreenState extends State<NotificationParentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<NotifyModel> listNoti = [];
  Future<void> getList() async {
    ApiResponse res = await ApiRequest.getNoti();
    if (res.code == 200) {
      for (var e in res.data) {
        listNoti.add(
          NotifyModel.fromJson(e),
        );
      }
      setState(() {});
    } else {
      print("");
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationList(),
                _buildSentNotificationList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontSize: 16, // Updated tab text size
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16, // Updated tab text size for unselected tabs
          fontWeight: FontWeight.w400,
        ),
        tabs: const [
          Tab(text: 'Quan trọng'),
          Tab(text: 'Thông báo đưa đón'),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ...listNoti.map(
          (e) {
            return _buildNotificationCard(
              sender: 'Admin',
              title: '[${e.title}]',
              content: e.message ?? "",
              time: DateFormat("HH:mm dd/MM/yyyy").format(
                DateTime.parse(e.createdAt ?? ""),
              ),
            );
          },
        ).toList(),
        _buildNotificationCard(
          sender: 'Admin',
          title: '[Cập nhật TKB đưa đón tháng 10]',
          content: 'Đã có thời khóa biểu đưa đón từ ngày 01/10 - 15/10/2024',
          time: '08:00 10/04/2023',
        ),
        _buildNotificationCard(
          sender: 'Admin',
          title: '[Thay đổi TBK đột xuất]',
          content: 'Thay đổi TKB do bão Ya-Gi',
          time: '08:00 10/04/2023',
        ),
        _buildNotificationCard(
          sender: 'Admin',
          title: '[Thay đổi tài xế đưa đón ngày 15/...',
          content:
              'Do tài xế xin nghỉ ngày 15/04/2024 nên thay đổi tài xế xe đưa đón ngày 15 là...',
          time: '08:00 10/04/2023',
        ),
        _buildNotificationCard(
          sender: 'Admin HVO',
          title: '[THÔNG BÁO NGHỈ HỌC NGÀY 14/0...',
          content:
              'Gửi phụ huynh các bé, hôm nay thời tiết lạnh chỉ 5 độ C, nhà trường thông báo...',
          time: '08:00 10/04/2023',
        ),
      ],
    );
  }

  Widget _buildSentNotificationList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _notificationSendCard(
            notification: StudentNotification(
          studentName: 'Nguyễn Viết Thắng',
          timestamp: DateTime(2023, 4, 10, 8, 0),
          type: NotificationType.pickup,
          status: 'đã lên xe đưa đón',
        )),
        _notificationSendCard(
          notification: StudentNotification(
            studentName: 'Nguyễn Viết Thắng',
            timestamp: DateTime(2023, 4, 10, 8, 30),
            type: NotificationType.dropoff,
            status: 'đã xuống xe đưa đón',
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required String sender,
    required String title,
    required String content,
    required String time,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationDetailScreen(),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Từ: $sender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationSendCard({
    required StudentNotification notification,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon based on type
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: notification.type == NotificationType.pickup
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                notification.type == NotificationType.pickup
                    ? AppImages.login1
                    : AppImages.logout1,
                color: notification.type == NotificationType.pickup
                    ? Colors.blue
                    : Colors.green,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.type == NotificationType.pickup
                            ? 'Đã đón học sinh'
                            : 'Đã trả học sinh',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle close button tap
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Học sinh ${notification.studentName} ${notification.type == NotificationType.pickup ? 'đã lên xe đưa đón' : 'đã xuống xe đưa đón'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _formatDateTime(notification.timestamp),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_padZero(dateTime.hour)}:${_padZero(dateTime.minute)} ${_padZero(dateTime.day)}/${_padZero(dateTime.month)}/${dateTime.year}';
  }

  String _padZero(int number) {
    return number.toString().padLeft(2, '0');
  }
}

enum NotificationType {
  pickup,
  dropoff,
}

class StudentNotification {
  final String studentName;
  final DateTime timestamp;
  final NotificationType type;
  final String status;

  StudentNotification({
    required this.studentName,
    required this.timestamp,
    required this.type,
    required this.status,
  });
}
