import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';
import 'package:pear_app/widgets/app_button.dart';

import '../widgets/custome_textfield.dart';
import 'home_screen.dart';

class GuardianshipScreen extends StatefulWidget {
  const GuardianshipScreen({Key? key}) : super(key: key);

  @override
  State<GuardianshipScreen> createState() => _GuardianshipScreenState();
}

class _GuardianshipScreenState extends State<GuardianshipScreen> {

  List<PickupStudent> student = [
    PickupStudent(point: 'Điểm đón Hoàng Mai', name: "Phạm Minh Anh", classStudent: "1A",image: AppImages.man),
    PickupStudent(point: 'Điểm đón Hai Bà Trưng', name: "Phạm Minh Anh", classStudent: "1A",image:AppImages.man),
  ];

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
                    'Giám hộ',
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24,),
                      const Text( "Học sinh",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: 8,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(student.length, (index){
                          final point = student[index];
                          return Card(
                            elevation: 0.3,
                            color: Colors.white,
                            // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: Image.asset(point.image,width: 40,height: 40,),
                              title: Text("${point.name} - ${point.classStudent}", style:const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("Điểm đón: ${point.point}"),
                              trailing:const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}