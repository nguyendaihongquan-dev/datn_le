import 'package:pear_app/screens/attendance_screen.dart';

class StudentsModel {
  int studentId;
  String fullName;
  String dob;
  String className;
  int userId;
  CheckStatus arrivalStatus;
  CheckStatus departureStatus;
  String stopId;

  StudentsModel({
    required this.studentId,
    required this.fullName,
    required this.dob,
    required this.className,
    required this.arrivalStatus,
    required this.departureStatus,
    required this.userId,
    required this.stopId,
  });

  StudentsModel.fromJson(Map<String, dynamic> json)
      : studentId = json['student_id'] ?? 0, // Giá trị mặc định là 0
        fullName = json['full_name'] ?? "Unknown", // Giá trị mặc định là "Unknown"
        dob = json['dob'] ?? "0000-00-00", // Giá trị mặc định cho ngày sinh
        className = json['class'] ?? "N/A", // Giá trị mặc định
        userId = json['user_id'] ?? 0, // Giá trị mặc định
        stopId = json['stop_id'] ?? "N/A", // Giá trị mặc định
        arrivalStatus = CheckStatus.values.firstWhere(
          (e) => e.toString() == 'CheckStatus.${json['arrival_status']}',
          orElse: () => CheckStatus.blank, // Nếu không tìm thấy, mặc định là blank
        ),
        departureStatus = CheckStatus.values.firstWhere(
          (e) => e.toString() == 'CheckStatus.${json['departure_status']}',
          orElse: () => CheckStatus.blank,
        );

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'full_name': fullName,
      'dob': dob,
      'class': className,
      'user_id': userId,
      'stop_id': stopId,
      'arrival_status': arrivalStatus.toString().split('.').last,
      'departure_status': departureStatus.toString().split('.').last,
    };
  }
}
