import 'package:flutter/material.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/provider/user_provider.dart';
import 'package:pear_app/utils/app_functions.dart';
import 'package:pear_app/widgets/app_button.dart';
import 'package:pear_app/widgets/error_dialog.dart';
import 'package:pear_app/widgets/success_dialog.dart';
import 'package:provider/provider.dart';

class ReflectScreen extends StatefulWidget {
  const ReflectScreen({super.key});

  @override
  State<ReflectScreen> createState() => _ReflectScreenState();
}

class _ReflectScreenState extends State<ReflectScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Tạo góp ý',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Tiêu đề:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(fontSize: 14),
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 1, color: Colors.black.withOpacity(0.3)),
                  Row(
                    children: [
                      const Text(
                        "Nội dung:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(fontSize: 14),
                          maxLines: null,
                          controller: contentController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: AppButton(
              onPressed: () async {
                AppFunctions.showLoading(context);
                Map<String, dynamic> data = {
                  "name": context.read<UserProvider>().userModel.fullName,
                  "email": context.read<UserProvider>().userModel.email,
                  "title": titleController.text,
                  "message": contentController.text,
                };
                ApiResponse res = await ApiRequest.createFeedback(data);
                if (res.code == 201) {
                  AppFunctions.hideLoading(context);
                  SuccessDialog.show(context, res.message);
                  Navigator.of(context).pop();
                } else {
                  AppFunctions.hideLoading(context);
                  ErrorDialog.show(context, res.message);
                }
              },
              text: "Gửi",
            ),
          )
        ],
      ),
    );
  }
}
