class FeedbackModel {
  int? id;
  String? name;
  String? email;
  String? message;
  String? title;
  String? status;
  String? createdAt;
  String? updatedAt;

  FeedbackModel(
      {this.id,
      this.name,
      this.email,
      this.message,
      this.title,
      this.status,
      this.createdAt,
      this.updatedAt});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    title = json["title"];
    message = json['message'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['message'] = this.message;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
