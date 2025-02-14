import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pear_app/model/feedback_model.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';

import 'attendance_view_screen.dart';

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackListScreen> createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  List<FeedbackModel> listFeedBack = [];
  Future<void> getListFeedback() async {
    ApiResponse res = await ApiRequest.getListFeedback();
    if (res.code == 200) {
      for (var e in res.data) {
        listFeedBack.add(FeedbackModel.fromJson(e));
      }
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    getListFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98E5DE),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Phản ánh',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      // Tab Bar
                      TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Chờ phản hồi',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Đã phản hồi',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        indicatorColor: Colors.blue,
                        indicatorWeight: 3,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.search_rounded,
                                        color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Tìm kiếm',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.filter_list_rounded,
                                      color: Colors.black),
                                  const SizedBox(width: 4),
                                  Text('Lọc'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: listFeedBack.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.send_rounded,
                                          color: Colors.blue, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Từ phụ huynh ${listFeedBack[index].name}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    listFeedBack[index].title ?? "",
                                    // getFeedbackTitle(index),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    listFeedBack[index].message ?? "",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "27.10.2002", //
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatVietnameseDate(DateTime dateTime) {
    // Lấy tên ngày trong tuần bằng tiếng Việt
    List<String> weekdays = [
      'Chủ Nhật',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7'
    ];

    String weekday =
        weekdays[dateTime.weekday % 7]; // weekday từ 1-7, Chủ Nhật là 0
    String day = DateFormat('dd').format(dateTime);
    String monthYear = DateFormat('MM/yyyy').format(dateTime);

    return "$weekday, $day/$monthYear";
  }

  String getFeedbackTitle(int index) {
    switch (index) {
      case 0:
        return '[PHẢN ẢNH THÁI ĐỘ GIÁO VIÊN]';
      case 1:
        return '[PHẢN ẢNH CHẤT LƯỢNG XE]';
      case 2:
        return '[PHẢN ẢNH THỜI GIAN ĐÓN]';
      default:
        return '';
    }
  }
}
