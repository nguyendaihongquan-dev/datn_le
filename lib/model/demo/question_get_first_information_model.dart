class QuestionGetFirstInformationModel {
  String? icon;
  String? question;
  List<String>? listAnswer;

  QuestionGetFirstInformationModel({this.icon, this.question, this.listAnswer});

  QuestionGetFirstInformationModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    question = json['question'];
    listAnswer = json['listAnswer'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['question'] = this.question;
    data['listAnswer'] = this.listAnswer;
    return data;
  }
}
