import 'package:flutter/material.dart';
import 'package:pear_app/res/images/app_images.dart';



class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<bool> _expandedStates = List.generate(5, (index) => index == 0);

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
                    'Điểm đón Hoàng Mai',
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
                child:  Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.purple.shade100,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.purple.shade200),
                              const SizedBox(width: 8),
                              const Text(
                                'Điểm đón: Hoàng Mai',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.people, color: Colors.purple.shade200),
                              const SizedBox(width: 8),
                              const Text(
                                'Sĩ số: 5',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                       child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final isEven = index % 2 == 0;
                          final studentData = {
                            'name': isEven ? 'Phạm Lan Mai - 1A' : 'Phạm Minh Anh - 3A',
                            'pickupPoint': 'Điểm đón: Điểm đón Hoàng Mai',
                            'studentId': 'MSHS: 20203480',
                            'birthDate': 'Ngày sinh: 15/04/2002',
                            'parent': 'Phụ huynh: Phạm Thị Lý',
                            'phone': 'SĐT liên hệ: 0385264690',
                            'avatar': AppImages.man
                          };

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ExpandableStudentCard(
                              studentData: studentData,
                              isExpanded: _expandedStates[index],
                              onToggle: () {
                                setState(() {
                                  _expandedStates[index] = !_expandedStates[index];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
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

class ExpandableStudentCard extends StatelessWidget {
  final Map<String, String> studentData;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ExpandableStudentCard({
    super.key,
    required this.studentData,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(studentData['avatar']!,width: 36,height: 36,),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentData['name']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          studentData['pickupPoint']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    ),
                    onPressed: onToggle,
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 36 + 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const  Icon(Icons.menu_book_rounded, size: 16,color: Colors.black54,),
                          const  SizedBox(width: 4,),
                          Expanded(child: Text(studentData['studentId']!)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person_2_rounded, size: 16,color: Colors.black54,),
                          const SizedBox(width: 4,),
                          Text(studentData['birthDate']!),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.people_alt_rounded, size: 16,color: Colors.black54,),
                          const SizedBox(width: 4,),
                          Text(studentData['parent']!),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const  Icon(Icons.phone_rounded, size: 16,color: Colors.black54,),
                          const SizedBox(width: 4,),
                          Text(studentData['phone']!),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}