import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pear_app/model/notify_model.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/theme/app_colors.dart';
import 'create_notify_screen.dart';
import 'detail_notify_screen.dart';

class NotificationTeacherScreen extends StatefulWidget {
  const NotificationTeacherScreen({super.key});

  @override
  State<NotificationTeacherScreen> createState() =>
      _NotificationTeacherScreenState();
}

class _NotificationTeacherScreenState extends State<NotificationTeacherScreen>
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
            child: Stack(
              children: [
                TabBarView(
                  controller: _tabController,
                  children: [
                    _buildNotificationList(),
                    _buildSentNotificationList(),
                  ],
                ),
                Positioned(
                  bottom: 8,
                  right: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateNotifyScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff1F92F1),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_circle,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Tạo thông báo",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                )
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
        labelStyle: TextStyle(
          fontSize: 16, // Updated tab text size
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16, // Updated tab text size for unselected tabs
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(text: 'Thông báo đến'),
          Tab(text: 'Thông báo đã gửi'),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView(
      padding: const EdgeInsets.all(16),
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
      padding: EdgeInsets.all(16),
      children: [],
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
}
