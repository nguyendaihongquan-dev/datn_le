import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/theme/app_colors.dart';

import '../widgets/profile_item.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7FFFD4), // Mint green background
      body: Scaffold(
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
                      'Tài xế',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                     child: Column(
                      children:[
                        const SizedBox(height: 24,),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(width: 3,color: AppColors.primary)
                          ),
                           padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Image.asset(
                              AppImages.man, // Add your avatar image here
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Nguyễn Việt Hoàng',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        //  SizedBox(height: 4),
                        const Text(
                          'Tài xế',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const ProfileItem(
                            icon: AppImages.profileGmail,
                            title: 'Gmail:',
                            subtitle: 'Buile1504@gmail.com',
                        ),
                        const ProfileItem(
                            icon: AppImages.profilePhone,
                            title: 'Số điện thoại:',
                            subtitle: '0981708157',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}