import 'package:flutter/material.dart';
import 'package:pear_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  Role role = Role.teacher;

  void setRole(Role value) {
    role = value;
    notifyListeners();
  }

  void initRole() {
    role = Role.teacher;
    notifyListeners();
  }

  UserModel userModel = UserModel();
  void saveUser(UserModel value) {
    userModel=value;
    notifyListeners();
  }
}

enum Role {
  teacher,
  parents,
  admin,
}
