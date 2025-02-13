class NotifyModel {
  int? id;
  String? title;
  String? message;
  String? createdAt;

  NotifyModel({this.id, this.title, this.message, this.createdAt});

  NotifyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
