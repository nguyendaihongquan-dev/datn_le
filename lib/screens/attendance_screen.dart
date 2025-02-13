import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pear_app/model/students_model.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/widgets/app_button.dart';
import 'package:firebase_database/firebase_database.dart';

enum CheckStatus {
  blank,
  checked,
  canceled,
}

class Student {
  final String name;
  final String className;
  CheckStatus leftCheckStatus;
  CheckStatus rightCheckStatus;

  Student({
    required this.name,
    required this.className,
    this.leftCheckStatus = CheckStatus.blank,
    this.rightCheckStatus = CheckStatus.blank,
  });
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // final List<Student> studentData = [
  //   Student(name: 'Nguyễn An Tường Anh', className: '3A'),
  //   Student(name: 'Nguyễn Lan Anh', className: '3A'),
  //   Student(name: 'Nguyễn Thị Bình', className: '3A'),
  //   Student(name: 'Nguyễn Thị Chung', className: '3A'),
  //   Student(name: 'Nguyễn Minh Dung', className: '3A'),
  // ];
  final List<StudentsModel> listStudents = [];
  bool isLeftColumnActive = false;
  bool isRightColumnActive = false;

  void cycleCheckStatus(int index, bool isLeft) {
    if ((isLeft && !isLeftColumnActive) || (!isLeft && !isRightColumnActive)) {
      return;
    }

    setState(() {
      if (isLeft) {
        switch (listStudents[index].arrivalStatus) {
          case CheckStatus.blank:
            listStudents[index].arrivalStatus = CheckStatus.checked;
            break;
          case CheckStatus.checked:
            listStudents[index].arrivalStatus = CheckStatus.canceled;
            break;
          case CheckStatus.canceled:
            listStudents[index].arrivalStatus = CheckStatus.blank;
            break;
        }
      } else {
        switch (listStudents[index].departureStatus) {
          case CheckStatus.blank:
            listStudents[index].departureStatus = CheckStatus.checked;
            break;
          case CheckStatus.checked:
            listStudents[index].departureStatus = CheckStatus.canceled;
            break;
          case CheckStatus.canceled:
            listStudents[index].departureStatus = CheckStatus.blank;
            break;
        }
      }
    });
  }

  Widget getCheckIcon(CheckStatus status) {
    switch (status) {
      case CheckStatus.blank:
        return Icon(Icons.check_box_outline_blank,
            color: Colors.black.withOpacity(0.15));
      case CheckStatus.checked:
        return const Icon(Icons.check, color: Colors.blue);
      case CheckStatus.canceled:
        return const Icon(Icons.close, color: Colors.red);
    }
  }

  void fetchAttendanceData() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    String date = DateFormat("dd-MM-yyyy")
        .format(DateTime.now()); // Thay bằng ngày tháng năm bạn muốn lấy

    for (int i = 1; i <= 5; i++) {
      // String path = "attendance/$date/Bus1/$i/arrive/arrive_state";
      String path = "attendance/13-02-2025/bus_1/24x00$i/arrive/arrive_state";
      DatabaseReference ref = databaseRef.child(path);
      ref.onValue.listen((event) {
        if (event.snapshot.exists) {
          bool arriveState = event.snapshot.value == true;
          if (arriveState) {
            listStudents.firstWhere((e) => e.studentId == i).arrivalStatus =
                CheckStatus.checked;
          }
          print("Bus1/$i: $arriveState ");
        } else {
          print("Bus1/$i: Không có dữ liệu");
        }
      });
    }

    setState(() {});
  }

  void fetchLeaveData() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    String date = DateFormat("dd-MM-yyyy")
        .format(DateTime.now()); // Thay bằng ngày tháng năm bạn muốn lấy

    for (int i = 1; i <= 5; i++) {
      // String path = "attendance/$date/Bus1/$i/arrive/arrive_state";
      String path = "attendance/13-02-2025/bus_1/24x00$i/leave/leave_state";
      DatabaseReference ref = databaseRef.child(path);
      ref.onValue.listen((event) {
        if (event.snapshot.exists) {
          bool arriveState = event.snapshot.value == true;
          if (arriveState) {
            listStudents.firstWhere((e) => e.studentId == i).departureStatus =
                CheckStatus.checked;
          }
          print("Bus1/$i: $arriveState ");
        } else {
          print("Bus1/$i: Không có dữ liệu");
        }
      });
    }

    setState(() {});
  }

  Future<String?> getList() async {
    ApiResponse res = await ApiRequest.getListStudents();
    if (res.code == 200) {
      for (var e in res.data) {
        listStudents.add(StudentsModel.fromJson(e));
      }
      setState(() {});

      return "ok";
    } else {
      return res.message;
    }
  }

  @override
  void initState() {
    getList().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        fetchAttendanceData();
        fetchLeaveData();
      });
    });
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
                child: Stack(
                  children: [
                    SingleChildScrollView(
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    'Lớp',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLeftColumnActive =
                                              !isLeftColumnActive;
                                          if (isLeftColumnActive) {
                                            isRightColumnActive = false;
                                          }
                                        });
                                        fetchAttendanceData();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isLeftColumnActive
                                              ? Colors.blue.shade50
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isLeftColumnActive
                                                ? Colors.blue.shade200
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        // child: Icon(
                                        //   Icons.exit_to_app,
                                        //   color: isLeftColumnActive
                                        //       ? Colors.blue
                                        //       : Colors.grey,
                                        // ),
                                        child: Image.asset(
                                          AppImages.login1,
                                          width: 14,
                                          height: 14,
                                          color: isLeftColumnActive
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isRightColumnActive =
                                              !isRightColumnActive;
                                          if (isRightColumnActive) {
                                            isLeftColumnActive = false;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isRightColumnActive
                                              ? Colors.blue.shade50
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isRightColumnActive
                                                ? Colors.blue.shade200
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Image.asset(
                                          AppImages.logout1,
                                          width: 14,
                                          height: 14,
                                          color: isRightColumnActive
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
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
                                    Icon(Icons.location_on,
                                        color: Colors.purple.shade200),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Điểm đón: Hoàng Mai',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.people,
                                        color: Colors.purple.shade200),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Sĩ số: 5',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                List.generate(listStudents.length, (index) {
                              final student = listStudents[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(student.fullName ?? ""),
                                    ),
                                    Expanded(
                                      child: Text(student.className ?? ""),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              cycleCheckStatus(index, true),
                                          child: getCheckIcon(
                                              student.arrivalStatus),
                                        ),
                                        const SizedBox(width: 16),
                                        GestureDetector(
                                          onTap: () =>
                                              cycleCheckStatus(index, false),
                                          child: getCheckIcon(
                                              student.departureStatus),
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
                    Positioned(
                        bottom: 16,
                        right: 16,
                        left: 16,
                        child: AppButton(
                          onPressed: () async {
                            List<Map<String, dynamic>> listData = [];
                            for (var e in listStudents) {
                              listData.add({
                                "student_id": e.studentId,
                                "route_id": 1,
                                "arrival_status":
                                    e.arrivalStatus == CheckStatus.checked,
                                "departure_status":
                                    e.departureStatus == CheckStatus.checked,
                                "attendance_date": DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now())
                              });
                            }
                            ApiResponse res =
                                await ApiRequest.checkAttendance(listData);
                            if (res.code == 200) {
                              print("oke");
                            } else {
                              print(res.message);
                            }
                          },
                          text: "Lưu điểm danh",
                          type: ButtonType.primary,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
