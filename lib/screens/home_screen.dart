import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/screens/schedule_screen.dart';
import 'package:pear_app/screens/teacher_profile_screen.dart';
import 'package:pear_app/utils/app_functions.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/user_provider.dart';
import '../theme/app_colors.dart';
import 'attendance_screen.dart';
import 'driver_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<PickupPoint> pickupPoints = [
    PickupPoint(
        name: 'Điểm đón Hoàng Mai', studentCount: 10, color: Colors.blue),
    PickupPoint(
        name: 'Điểm đón Hai Bà Trưng', studentCount: 10, color: Colors.yellow),
    PickupPoint(name: 'Điểm đón Đống Đa', studentCount: 10, color: Colors.blue),
    PickupPoint(name: 'Điểm đón Đống Đa', studentCount: 10, color: Colors.blue),
  ];

  List<PickupStudent> pickupStudent = [
    PickupStudent(
        point: 'Điểm đón Hoàng Mai',
        name: "Phạm Minh Anh",
        classStudent: "1A",
        image: AppImages.man),
    PickupStudent(
        point: 'Điểm đón Hai Bà Trưng',
        name: "Phạm Minh Anh",
        classStudent: "1A",
        image: AppImages.man),
    PickupStudent(
        point: 'Điểm đón Đống Đa',
        name: "Phạm Minh Anh",
        classStudent: "1A",
        image: AppImages.man),
    PickupStudent(
        point: 'Điểm đón Đống Đa',
        name: "Phạm Minh Anh",
        classStudent: "1A",
        image: AppImages.man),
  ];

  String _formatMonthYear(DateTime date) {
    return 'Tháng ${date.month}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      helpText: "",
      confirmText: "Chọn",
      cancelText: "Hủy",
      initialDate: _focusedDay,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (picked != null && picked != _focusedDay) {
      setState(() {
        _selectedDay = picked;
        _focusedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: const Color(0xff8FE1D7),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16,
                                  MediaQuery.of(context).padding.top, 16, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xff72E1C0)),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          padding: const EdgeInsets.all(5),
                                          child: Image.asset(AppImages.man),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Xin chào!\n",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600]),
                                                ),
                                                TextSpan(
                                                  text: user.userModel.fullName,
                                                  style:const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: const Color(0xff00C7A3)),
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
                                            Text("Xem thời khóa biểu",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          child: Icon(
                                            Icons.calendar_month_rounded,
                                            size: 20,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              _focusedDay =
                                                  _focusedDay.subtract(
                                                      const Duration(days: 7));
                                            });
                                          },
                                          child: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            size: 24,
                                          )),
                                      Expanded(
                                        child: TableCalendar(
                                          firstDay: DateTime.utc(2020, 1, 1),
                                          lastDay: DateTime.utc(2030, 12, 31),
                                          focusedDay: _focusedDay,
                                          calendarFormat: calendarFormat,
                                          selectedDayPredicate: (day) {
                                            return isSameDay(_selectedDay, day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            setState(() {
                                              _selectedDay = selectedDay;
                                              _focusedDay = focusedDay;
                                            });
                                          },
                                          onPageChanged: (focusedDay) {
                                            _focusedDay = focusedDay;
                                          },
                                          locale: 'vi',
                                          headerStyle: HeaderStyle(
                                            formatButtonVisible: false,
                                            titleCentered: true,
                                            titleTextFormatter:
                                                (date, locale) =>
                                                    _formatMonthYear(date),
                                            titleTextStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            leftChevronIcon:
                                                const SizedBox.shrink(),
                                            rightChevronIcon:
                                                const SizedBox.shrink(),
                                          ),
                                          calendarStyle: const CalendarStyle(
                                            selectedDecoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            selectedTextStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            // todayDecoration: BoxDecoration(
                                            //   color: Colors.lightBlueAccent,
                                            //   shape: BoxShape.circle,
                                            // ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              _focusedDay = _focusedDay
                                                  .add(const Duration(days: 7));
                                            });
                                          },
                                          child: const Icon(
                                              Icons.arrow_forward_ios_rounded)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30)),
                                color: Colors.white,
                              ),
                              height: 30,
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                _selectedDay == null
                                    ? "Ngày ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                    : "Ngày ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                _buildInfoCard(
                                    icon: AppImages.car1,
                                    title: "Biển số",
                                    value: "17B2-215326",
                                    color: Colors.green.shade100,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ScheduleScreen(),
                                        ),
                                      );
                                    }),
                                _buildInfoCard(
                                    icon: AppImages.man,
                                    title: "Tài xế",
                                    value: "Nguyễn Việt Hoàng",
                                    color: Colors.amber.shade100,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DriverProfileScreen(),
                                        ),
                                      );
                                    }),
                                user.role == Role.teacher
                                    ? _buildInfoCard(
                                        icon: AppImages.image3,
                                        title: "Học sinh",
                                        value: "30",
                                        color: Colors.blue.shade100,
                                        onTap: () {})
                                    : user.role == Role.parents
                                        ? _buildInfoCard(
                                            icon: AppImages.image3,
                                            title: "Giáo viên",
                                            value: "Nguyễn Viết Thắng",
                                            color: Colors.blue.shade100,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TeacherProfileScreen(),
                                                ),
                                              );
                                            })
                                        : const SizedBox.shrink(),
                              ].addBetween(const SizedBox(
                                width: 8,
                              )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            user.role == Role.teacher
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(pickupPoints.length,
                                        (index) {
                                      final point = pickupPoints[index];
                                      return Card(
                                        elevation: 0.3,
                                        color: Colors.white,
                                        // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: ListTile(
                                          leading: Icon(Icons.menu_book_rounded,
                                              color: point.color),
                                          title: Text(point.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text(
                                              "Số lượng học sinh: ${point.studentCount}"),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16),
                                        ),
                                      );
                                    }),
                                  )
                                : user.role == Role.parents
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                            pickupStudent.length, (index) {
                                          final point = pickupStudent[index];
                                          return Card(
                                            elevation: 0.3,
                                            color: Colors.white,
                                            // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            child: ListTile(
                                              leading: Image.asset(
                                                point.image,
                                                width: 40,
                                                height: 40,
                                              ),
                                              title: Text(
                                                  "${point.name} - ${point.classStudent}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  "Điểm đón: ${point.point}"),
                                              trailing: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 16),
                                            ),
                                          );
                                        }),
                                      )
                                    : const SizedBox.shrink()
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 16,
              child: user.role == Role.teacher
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AttendanceScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff1F92F1)),
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
                            Text("Điểm danh",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white))
                          ],
                        ),
                      ),
                    )
                  : user.role == Role.parents
                      ? InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>  const AttendanceScreen(),
                            //   ),
                            // );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff1F92F1)),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("Phản ánh",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white))
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
            )
          ],
        ),
      );
    });
  }

  Widget _buildInfoCard(
      {required String icon,
      required String title,
      required String value,
      required Color color,
      required Function() onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 110,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  icon,
                ),
              ),
              const SizedBox(height: 4),
              AutoSizeText(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                maxFontSize: 14,
                minFontSize: 1,
              ),
              AutoSizeText(
                value,
                maxLines: 1,
                maxFontSize: 14,
                minFontSize: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PickupPoint {
  final String name;
  final int studentCount;
  final Color color;

  PickupPoint(
      {required this.name, required this.studentCount, required this.color});
}

class PickupStudent {
  final String name;
  final String point;
  final String classStudent;
  final String image;

  PickupStudent(
      {required this.name,
      required this.point,
      required this.classStudent,
      required this.image});
}
