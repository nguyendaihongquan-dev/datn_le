import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pear_app/provider/login_provider.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/theme/app_colors.dart';
import 'package:pear_app/utils/app_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/user_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/checkbox.dart';
import '../widgets/custome_textfield.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool remember = false;

  Future<void> _saveLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (remember) {
      await prefs.setString('username', usernameController.text.trim());
      await prefs.setString('password', passwordController.text.trim());
      await prefs.setBool('remember', true);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.setBool('remember', false);
    }
  }

  Future<void> _loadLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    bool isRemember = prefs.getBool('remember') ?? false;

    if (isRemember) {
      usernameController.text = prefs.getString('username') ?? "";
      passwordController.text = prefs.getString('password') ?? "";
      remember = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, UserProvider>(
        builder: (context, login, user, child) {
      return Scaffold(
        backgroundColor: const Color(0xffF0F4F3),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.image8,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              user.setRole(Role.teacher);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 3,
                                    color: user.role == Role.teacher
                                        ? AppColors.primary
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Giáo viên",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              user.setRole(Role.parents);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: user.role == Role.parents
                                              ? AppColors.primary
                                              : Colors.transparent))),
                              alignment: Alignment.center,
                              child: const Text(
                                "Phụ huynh",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              user.setRole(Role.admin);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: user.role == Role.admin
                                              ? AppColors.primary
                                              : Colors.transparent))),
                              alignment: Alignment.center,
                              child: const Text(
                                "Admin",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Normal text input
                    CustomTextField(
                      label: "Tên đăng nhập",
                      type: TextFieldType.normal,
                      controller: usernameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Mật khẩu",
                      type: TextFieldType.password,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppCheckBox(
                              onTap: () {
                                remember = !remember;
                                setState(() {});
                              },
                              tap: remember,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text('Nhớ tài khoản'),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(color: AppColors.primary),
                            )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      onPressed: () async {
                        AppFunctions.showLoading(context);
                        var res = await login.userLogin(
                          userName: usernameController.text.trim(),
                          passWord: passwordController.text.trim(),
                        );
                        if (res == "ok" && context.mounted) {
                          await _saveLoginInfo();
                          user.saveUser(login.userModel);
                          if (user.userModel.role == "TEACHER") {
                            user.setRole(Role.teacher);
                          } else if (user.userModel.role == "PARENT") {
                            user.setRole(Role.parents);
                          } else {
                            user.setRole(Role.admin);
                          }
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.userModel.email)
                              .set({
                            "username": user.userModel.fullName,
                            "email": user.userModel.email,
                          });
                          AppFunctions.hideLoading(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavigation(),
                            ),
                          );
                        } else {
                          if (context.mounted) {
                            AppFunctions.hideLoading(context);
                            // AppFunctions.showCustomSnackbarError(
                            //   context,
                            //   message: res ?? "Lỗi không xác đinh",
                            // );
                          }
                        }
                        // await Future.
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const BottomNavigation(),
                        //   ),
                        // );
                      },
                      text: 'Đăng nhập',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
