class UserModel {
  String? fullName;
  String? email;
  String? role;

  UserModel({this.fullName, this.email, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
