import 'package:flutter/material.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/screens/select_receiver_dialog.dart';
import 'package:pear_app/widgets/app_button.dart';

class CreateNotifyScreen extends StatefulWidget {
  const CreateNotifyScreen({super.key});

  @override
  State<CreateNotifyScreen> createState() => _CreateNotifyScreenState();
}

class _CreateNotifyScreenState extends State<CreateNotifyScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<Receiver> selectedReceivers = [];

  void _showSelectReceiverDialog() {
    showDialog(
      context: context,
      builder: (context) => SelectReceiverDialog(
        onSave: (receivers) {
          setState(() {
            selectedReceivers = receivers;
          });
        },
      ),
    );
  }

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
          'Tạo thông báo',
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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      const Text(
                        "Người nhận:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      if (selectedReceivers.isNotEmpty)
                        ...selectedReceivers.map(
                          (receiver) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              receiver.name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: _showSelectReceiverDialog,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff008955),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Chọn người nhận",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff008955),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.add,
                                color: Color(0xff008955),
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, color: Colors.black.withOpacity(0.3)),
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
                Map<String, dynamic> data = {
                  "title": titleController.text,
                  "message": contentController.text
                };
                ApiResponse res = await ApiRequest.createNoti(data);
                if (res.code == 201) {
                } else {
                  print(res.message);
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
