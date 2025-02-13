import 'package:flutter/material.dart';
import 'package:pear_app/model/user_model.dart';
import 'package:pear_app/network/api/api_response.dart';
import 'package:pear_app/network/api_request.dart';
import 'package:pear_app/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  UserModel userModel = UserModel();
  Future<String?> userLogin({
    required String userName,
    required String passWord,
  }) async {
    ApiResponse res = await ApiRequest.userLogin(
      password: passWord,
      username: userName,
      // rememberMe: rememberMe,
    );
    if (res.code == 200) {
      String token = res.data["token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);
      userModel = UserModel.fromJson(
        res.data["user"],
      );
      // await prefs.setString('username', userNameController.text);
      // await prefs.setBool('logged', remember);
      notifyListeners();
      return "ok";
    } else {
      notifyListeners();
      return res.message;
    }
  }
}
