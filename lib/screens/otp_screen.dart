import 'package:flutter/material.dart';
import 'package:pear_app/screens/reset_password_screen.dart';
import 'package:pinput/pinput.dart';

import '../widgets/app_button.dart';

class OTPVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nhập OTP",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "OTP đã được gửi về số điện thoại\n",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const TextSpan(
                    text: "“0969 572 888”",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 45,
                  height: 64,
                  textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onCompleted: (pin) {
                  print('Mã OTP: $pin');
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
                children: [
                  Icon(Icons.refresh, color: Colors.blue),
                  SizedBox(width: 4,),
                  Text(
                    "Gửi lại OTP",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            Spacer(),
            AppButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              );
            },text: 'Tiếp tục',),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
