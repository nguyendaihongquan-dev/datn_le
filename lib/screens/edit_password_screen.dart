import 'package:flutter/material.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/screens/new_messages.dart';
import 'package:pear_app/utils/app_functions.dart';
import 'package:pear_app/widgets/app_button.dart';
import 'package:pear_app/widgets/error_dialog.dart';
import 'package:pear_app/widgets/success_dialog.dart';

import '../widgets/custome_textfield.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                    'Đổi mật khẩu',
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
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            CustomTextField(
                              label: "Mật khẩu cũ",
                              type: TextFieldType.password,
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              label: "Mật khẩu mới",
                              type: TextFieldType.password,
                              controller: newPasswordController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              label: "Nhập lại mật khẩu mới",
                              type: TextFieldType.password,
                              controller: confirmPasswordController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: AppButton(
                      onPressed: () async {
                        AppFunctions.showLoading(context);
                        Map<String, dynamic> data = {
                          "oldPassword": passwordController.text.trim(),
                          "newPassword": newPasswordController.text.trim()
                        };

                        ApiResponse res = await ApiRequest.changePass(data);
                        if (res.code == 200) {
                          AppFunctions.hideLoading(context);
                          SuccessDialog.show(context, res.message);
                        } else {
                          AppFunctions.hideLoading(context);
                          ErrorDialog.show(context, res.message);
                        }
                      },
                      text: "Lưu",
                      type: ButtonType.primary,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
