import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/widgets/app_button.dart';

import '../widgets/custome_textfield.dart';

class EditGmailScreen extends StatefulWidget {
  const EditGmailScreen({Key? key}) : super(key: key);

  @override
  State<EditGmailScreen> createState() => _EditGmailScreenState();
}

class _EditGmailScreenState extends State<EditGmailScreen> {

  TextEditingController gmail = TextEditingController(text: "Buile1504@gmail.com");

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
                    'Gmail',
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const  SizedBox(height: 24,),
                    CustomTextField(
                      label: 'Cập nhật gmail',
                      type: TextFieldType.normal,
                      controller: gmail,
                    ),
                    const Spacer(),
                    const  SizedBox(height: 16,),
                    AppButton(onPressed: (){},text: "Lưu",type: ButtonType.primary,),
                    const  SizedBox(height: 16,),
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