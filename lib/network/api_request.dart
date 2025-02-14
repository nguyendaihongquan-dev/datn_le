import 'dart:convert';
import 'package:pear_app/network/api/api_client.dart';
import 'package:pear_app/network/api/api_response.dart';

class ApiRequest {
  static const String domain = "http://160.30.136.119:8989";

  static Future<ApiResponse> userLogin({
    required String password,
    required String username,
    // required bool rememberMe,
  }) async {
    Map data = {
      "email": username,
      "password": password,
      // "rememberMe": rememberMe,
    };
    return await ApiClient().request(
        url: "$domain/auth/login",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> getListStudents() async {
    return await ApiClient().request(
      url: "$domain/users/students",
      method: ApiClient.get,
    );
  }

  static Future<ApiResponse> getListStudentsByMe() async {
    return await ApiClient().request(
      url: "$domain/users/students/me",
      method: ApiClient.get,
    );
  }

  static Future<ApiResponse> checkAttendance(
      List<Map<String, dynamic>> listData) async {
    return await ApiClient().request(
      url: "$domain/attendance",
      data: json.encode(listData),
      method: ApiClient.post,
    );
  }

  static Future<ApiResponse> changePass(Map<String, dynamic> data) async {
    return await ApiClient().request(
      url: "$domain/auth/forget",
      data: json.encode(data),
      method: ApiClient.post,
    );
  }

  static Future<ApiResponse> createNoti(Map<String, dynamic> value) async {
    return await ApiClient().request(
      url: "$domain/notification",
      data: json.encode(value),
      method: ApiClient.post,
    );
  }

  static Future<ApiResponse> getNoti() async {
    return await ApiClient().request(
      url: "$domain/notification",
      method: ApiClient.get,
    );
  }

  static Future<ApiResponse> createFeedback(Map<String, dynamic> value) async {
    return await ApiClient().request(
      url: "$domain/feedbacks",
      data: json.encode(value),
      method: ApiClient.post,
    );
  }

  static Future<ApiResponse> getListFeedback() async {
    return await ApiClient().request(
      url: "$domain/feedbacks",
      method: ApiClient.get,
    );
  }

  //register
  static Future<ApiResponse> userRegister({
    required String username,
    required String password,
    required String email,
    required String mobileNumber,
    String? affiliateCode,
    required String transactionCode,
  }) async {
    Map data = {
      "username": username,
      "password": password,
      "email": email,
      "mobileNumber": mobileNumber,
      "affiliateCode": affiliateCode,
      "transactionCode": transactionCode,
    };
    return await ApiClient().request(
        url: "$domain/api/v1/auth/user/register",
        data: json.encode(data),
        method: ApiClient.post);
  }

  //send-verify-password
  static Future<ApiResponse> sendVerifyPassword(String email) async {
    Map data = {"email": email};
    return await ApiClient().request(
        url: "$domain/api/v1/auth/send-verify/reset-password",
        data: json.encode(data),
        method: ApiClient.post);
  }

  //verify-password
  static Future<ApiResponse> verifyPassword(
      {required String email, required String code}) async {
    Map data = {"email": email, "code": code};
    return await ApiClient().request(
        url: "$domain/api/v1/auth/verify/reset-password",
        data: json.encode(data),
        method: ApiClient.post);
  }

  //reset-password
  static Future<ApiResponse> resetPass(
      {required String password,
      required String confirmPassword,
      required String token}) async {
    Map data = {"password": password, "confirmPassword": confirmPassword};
    return await ApiClient().request(
        url: "$domain/api/v1/auth/reset-password/$token",
        data: json.encode(data),
        method: ApiClient.post);
  }

  //profile
  static Future<ApiResponse> getUserInfo() async {
    return await ApiClient()
        .request(url: "$domain/api/v1/user/account", method: ApiClient.get);
  }
}
