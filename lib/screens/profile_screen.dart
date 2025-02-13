import 'package:flutter/material.dart';
import 'package:pear_app/model/user_model.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/screens/edit_gmail.screen.dart';
import 'package:pear_app/screens/edit_password_screen.dart';
import 'package:pear_app/screens/edit_phonenumber_screen.dart';
import 'package:pear_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../utils/app_functions.dart';
import '../widgets/profile_item.dart';
import 'guardianship_scren.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, child) {
      return Scaffold(
        backgroundColor: const Color(0xff8FE1D7),
        body: Column(
          children: [
            // Profile Header
            _buildProfileHeader(
              context,
              user.userModel,
            ),
            // Profile Menu
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _buildProfileMenu(context, user.userModel),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 24, bottom: 24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.man, // Add your avatar image here
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            user.fullName ?? "",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          //  SizedBox(height: 4),
          const Text(
            '10/02/1990',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, UserModel user) {
    // final user = context.read<UserProvider>();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProfileItem(
            icon: AppImages.profileGmail,
            title: 'Gmail:',
            subtitle: user.email,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditGmailScreen(),
                ),
              );
            }),
        ProfileItem(
            icon: AppImages.profilePhone,
            title: 'Số điện thoại:',
            subtitle: '0981708157',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditPhonenumberScreen(),
                ),
              );
            }),
        user.role == Role.parents
            ? ProfileItem(
                icon: AppImages.group33303,
                title: 'Giám hộ:',
                subtitle: '2 học sinh',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuardianshipScreen(),
                    ),
                  );
                })
            : const SizedBox.shrink(),
        ProfileItem(
            icon: AppImages.profilePassword,
            title: 'Đổi mật khẩu',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditPasswordScreen(),
                ),
              );
            }),
        ProfileItem(
            icon: AppImages.profileLogout,
            title: 'Đăng xuất',
            onTap: () {
              AppFunctions.showDialogAlert(context,
                  title: "ĐĂNG XUẤT",
                  description:
                      const Text("Xác nhận đăng xuất khỏi tài khoàn này?"),
                  dialogDismiss: false,
                  textConfirm: "Xác nhận", onPressConfirm: () async {
                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              }, textCancel: "Hủy", hideButtonClose: true);
            }),
      ],
    );
  }
}
