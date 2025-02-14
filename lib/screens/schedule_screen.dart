import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  double lat = 0;
  double long = 0;
  late final DatabaseReference _databaseReference;
  void _setDeviceState(String path, bool state) async {
    _databaseReference = FirebaseDatabase.instance.ref('/control').child(path);

    try {
      await _databaseReference.set(state);
      print("Giá trị đã cập nhật: $state");
    } catch (e) {
      print("Lỗi khi cập nhật Firebase: $e");
    }
  }

  Future<void> _initData() async {
    DatabaseReference latFirebase =
        FirebaseDatabase.instance.ref('/location/bus_1').child('lat');
    DatabaseReference longFirebase =
        FirebaseDatabase.instance.ref('/location/bus_1').child('long');

    latFirebase.onValue.listen((event) {
      var data = event.snapshot.value;
      setState(() {
        lat = double.parse(data.toString());
      });
    });

    longFirebase.onValue.listen((event) {
      var data = event.snapshot.value;
      setState(() {
        long = double.parse(data.toString());
      });
    });
    //monitor
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7FFFD4), // Mint green background
      body: Scaffold(
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
                      'Chi tiết',
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  //  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Image.asset(
                          AppImages.image13,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // Destination
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                          Icons.location_on_rounded,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(width: 16),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Điểm đến',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Trường tiểu học Nguyễn Xá',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                Container(
                                  height: 1,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                          Icons.access_time_filled_rounded,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(width: 16),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Thời gian tới dự kiến',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '08:30 AM',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                Container(
                                  height: 1,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                                const SizedBox(height: 12),

                                _buildTimelineItem(
                                  'Điểm đón Hoàng Mai',
                                  '11:00:21',
                                  Icons.location_on_rounded,
                                  true,
                                ),
                                _buildTimelineItem(
                                  'Trường Tiểu học Nguyễn Xá',
                                  '10:30:21',
                                  Icons.school_rounded,
                                  true,
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  height: 1,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                                const SizedBox(height: 12),
                                _buildTimelineItem(
                                  'Trường Tiểu học Nguyễn Xá',
                                  '08:00:22',
                                  Icons.school_rounded,
                                  true,
                                ),
                                _buildTimelineItem(
                                  'Điểm đón Hoàng Mai',
                                  '07:30:21',
                                  Icons.location_on_rounded,
                                  true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
      String title, String time, IconData icon, bool showLine) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Icon(icon, size: 20, color: Colors.grey[600]),
        ),
        if (showLine)
          Container(
            width: 2,
            height: 30,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
