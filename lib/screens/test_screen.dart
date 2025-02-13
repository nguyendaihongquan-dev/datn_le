import 'package:flutter/material.dart';

// Enum for notification types
enum NotificationType {
  pickup,
  dropoff,
}

// Notification data model
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

class StudentNotificationList extends StatelessWidget {
  final List<StudentNotification> notifications;

  const StudentNotificationList({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return NotificationCard(notification: notifications[index]);
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final StudentNotification notification;

  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Icon(
                notification.type == NotificationType.pickup
                    ? Icons.arrow_circle_right_outlined
                    : Icons.arrow_circle_left_outlined,
                color: notification.type == NotificationType.pickup
                    ? Colors.blue
                    : Colors.green,
                size: 24,
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
                  Text(
                    _formatDateTime(notification.timestamp),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
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

// Example usage
class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final List<StudentNotification> sampleNotifications = [
    StudentNotification(
      studentName: 'Nguyễn Viết Thắng',
      timestamp: DateTime(2023, 4, 10, 8, 0),
      type: NotificationType.pickup,
      status: 'đã lên xe đưa đón',
    ),
    StudentNotification(
      studentName: 'Nguyễn Viết Thắng',
      timestamp: DateTime(2023, 4, 10, 8, 30),
      type: NotificationType.dropoff,
      status: 'đã xuống xe đưa đón',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: StudentNotificationList(
          notifications: sampleNotifications,
        ),
      ),
    );
  }
}