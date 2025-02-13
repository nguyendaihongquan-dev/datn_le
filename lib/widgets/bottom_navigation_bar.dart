import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pear_app/screens/chat_noti_screen.dart';
import 'package:pear_app/utils/app_functions.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../res/images/app_images.dart';
import '../screens/chat_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notify_parents_screen.dart';
import '../screens/notify_teacher_screen.dart';
import '../screens/profile_screen.dart';
import '../theme/app_colors.dart';

class BottomNavigation extends StatefulWidget {
  final int? initIndex;
  const BottomNavigation({super.key, this.initIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initData(context));
  }

  void _initData(BuildContext context) {
    final user = context.read<UserProvider>();

    widgetOptions = <Widget>[
      const HomeScreen(),
      // ChatListScreen()
      ChatScreen(),
      user.role == Role.teacher
          ? const NotificationTeacherScreen()
          : user.role == Role.parents
              ? const NotificationParentsScreen()
              : const SizedBox.shrink(),
      const ProfileScreen(),
    ];

    if (widget.initIndex != null) {
      selectedIndex = widget.initIndex!;
      setState(() {});
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var horizontalRatio = (MediaQuery.of(context).size.width) / 393;
    return Scaffold(
      body: widgetOptions.isNotEmpty
          ? widgetOptions.elementAt(selectedIndex)
          : const SizedBox.shrink(),
      bottomNavigationBar: Container(
        color: Colors.white,
        // padding: const EdgeInsets.only(bottom: 16),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: 0,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      selectedIndex == 0
                          ? AppImages.homeSelected
                          : AppImages.home,
                      width: 24,
                      height: 24),
                  Text(
                    'Trang chủ',
                    style: TextStyle(
                        fontSize: 12,
                        color: selectedIndex == 0
                            ? const Color(0xff2F9FFD)
                            : const Color(0xff5B6064)),
                  )
                ],
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      selectedIndex == 1
                          ? AppImages.sendSelected
                          : AppImages.send,
                      width: 24,
                      height: 24),
                  Text(
                    'Chat',
                    style: TextStyle(
                        fontSize: 12,
                        color: selectedIndex == 1
                            ? const Color(0xff2F9FFD)
                            : const Color(0xff5B6064)),
                  )
                ],
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      selectedIndex == 2
                          ? AppImages.notificationSelected
                          : AppImages.notification,
                      width: 24,
                      height: 24),
                  Text(
                    'Thông báo',
                    style: TextStyle(
                        fontSize: 12,
                        color: selectedIndex == 2
                            ? const Color(0xff2F9FFD)
                            : const Color(0xff5B6064)),
                  )
                ],
              ),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      selectedIndex == 3
                          ? AppImages.profileSelected
                          : AppImages.profile,
                      width: 24,
                      height: 24),
                  Text(
                    'Cá nhân',
                    style: TextStyle(
                        fontSize: 12,
                        color: selectedIndex == 3
                            ? const Color(0xff2F9FFD)
                            : const Color(0xff5B6064)),
                  )
                ],
              ),
              label: 'Cá nhân',
            ),
          ],
        ),
      ),
    );
  }
}
