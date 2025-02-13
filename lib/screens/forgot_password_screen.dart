import 'package:flutter/material.dart';
import 'package:pear_app/theme/app_colors.dart';
import 'package:pear_app/widgets/app_button.dart';

import '../widgets/custome_textfield.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quên mật khẩu?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Vui lòng nhập số điện thoại để lấy lại mật khẩu. Mã OTP xác thực sẽ được gửi về số điện thoại.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: "Số điện thoại",
              type: TextFieldType.phone,
              controller: phoneController,
            ),
             const Spacer(),
            AppButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPVerificationScreen(),
                ),
              );
            },text: 'Tiếp tục',),
            const SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}