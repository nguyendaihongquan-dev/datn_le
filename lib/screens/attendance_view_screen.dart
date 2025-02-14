import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/widgets/app_button.dart';

enum Status{
  present,
  absent,
  cantCheck
}

class Student {
  final String name;
  final String className;
  final Status enter;
  final Status out;

  Student({
    required this.name,
    required this.className,
    required this.enter,
    required this.out,
  });
}


class AttendanceViewScreen extends StatefulWidget {
  const AttendanceViewScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceViewScreen> createState() => _AttendanceViewScreenState();
}

class _AttendanceViewScreenState extends State<AttendanceViewScreen> {

   List<Student> studentData = [
    Student(name: 'Nguyễn An Tường Anh', className: '3A', enter: Status.present, out: Status.present),
    Student(name: 'Nguyễn Lan Anh', className: '3A', enter: Status.absent, out: Status.cantCheck),
    Student(name: 'Nguyễn Thị Bình', className: '3A', enter: Status.present, out: Status.present),
    Student(name: 'Nguyễn Thị Chung', className: '3A', enter: Status.present, out: Status.absent),
    Student(name: 'Nguyễn Minh Dung', className: '3A', enter: Status.present, out: Status.absent),
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
                    'Tuyến A',
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Họ và tên',
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'Lớp',
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:  Colors.grey.shade300,
                                    ),
                                  ),
                                  // child: Icon(
                                  //   Icons.exit_to_app,
                                  //   color: isLeftColumnActive
                                  //       ? Colors.blue
                                  //       : Colors.grey,
                                  // ),
                                  child: Image.asset(AppImages.login1,width: 14,height: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:  Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Image.asset(AppImages.logout1,width: 14,height: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                        children: List.generate(studentData.length, (index){
                          final student = studentData[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(student.name),
                                ),
                                Expanded(
                                  child: Text(student.className),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      student.enter == Status.present
                                          ? Icons.check : student.enter == Status.absent
                                          ? Icons.close : Icons.check_box_outline_blank,
                                      color:student.enter == Status.present
                                          ? Colors.blue : student.enter == Status.absent
                                          ? Colors.red : Colors.black.withOpacity(0.15),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(
                                      student.out == Status.present
                                          ? Icons.check : student.out == Status.absent
                                          ? Icons.close : Icons.check_box_outline_blank,
                                      color:student.out == Status.present
                                          ? Colors.blue : student.out == Status.absent
                                          ? Colors.red : Colors.black.withOpacity(0.15),
                                    ),
                                  ],
                                ),
                              ],
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
}