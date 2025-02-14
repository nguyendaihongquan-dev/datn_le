import 'package:flutter/material.dart';

import 'attendance_view_screen.dart';
import 'home_screen.dart';
import 'list_students_in_point_screen.dart';



class RouteViewScreen extends StatefulWidget {
  const RouteViewScreen({Key? key}) : super(key: key);

  @override
  State<RouteViewScreen> createState() => _RouteViewScreenState();
}

class _RouteViewScreenState extends State<RouteViewScreen> {

  List<PickupPoint> pickupPoints = [
    PickupPoint(name: 'Điểm đón Hoàng Mai', studentCount: 10, color: Colors.blue),
    PickupPoint(name: 'Điểm đón Hai Bà Trưng', studentCount: 10, color: Colors.yellow),
    PickupPoint(name: 'Điểm đón Đống Đa', studentCount: 10, color: Colors.blue),
    PickupPoint(name: 'Điểm đón Đống Đa', studentCount: 10, color: Colors.blue),
  ];


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
                    'Tuyến đường',
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
                          'Tuyến đường A',
                          style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.purple.shade100,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded, color: Colors.purple.shade200),
                                const SizedBox(width: 8),
                                const Text(
                                  'Điểm đón: Hoàng Mai',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.people, color: Colors.purple.shade200),
                                const SizedBox(width: 8),
                                const Text(
                                  'Sĩ số: 5',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(pickupPoints.length, (index){
                          final point = pickupPoints[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const StudentListScreen(),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 0.3,
                              color: Colors.white,
                              // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: Icon(Icons.menu_book_rounded, color: point.color),
                                title: Text(point.name, style:const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text("Số lượng học sinh: ${point.studentCount}"),
                                trailing:const Icon(Icons.arrow_forward_ios, size: 16),
                              ),
                            ),
                          );
                        }),
                      )
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
