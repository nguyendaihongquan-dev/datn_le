import 'package:flutter/material.dart';

import 'attendance_view_screen.dart';



class ListAttendanceRouteScreen extends StatelessWidget {
  const ListAttendanceRouteScreen({Key? key}) : super(key: key);

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
                    'Điểm danh',
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date header
                      const SizedBox(height: 20),
                      const Text(
                        'Thứ 4, 11/02/2023',
                          style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const AttendanceViewScreen(),
                           ),
                         );
                       },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F0FF),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.purple.shade100,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                icon: Icons.map_rounded,
                                text: 'Tuyến đường A',
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                icon: Icons.location_on_rounded,
                                text: 'Điểm bắt đầu: Hoàng Mai',
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                icon: Icons.school_rounded,
                                text: 'Giáo viên: Nguyễn Viết Thắng',
                                showArrow: true,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                icon: Icons.person_2_rounded,
                                text: 'Tài xế: Bùi Thị Lê',
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                icon: Icons.directions_bus_rounded,
                                text: 'Biển số: 17L3-3593',
                              ),
                            ],
                          ),
                        ),
                      ),
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
  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    bool showArrow = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.purple.shade200),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        if (showArrow)
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Colors.black54,
          ),
      ],
    );
  }
}
