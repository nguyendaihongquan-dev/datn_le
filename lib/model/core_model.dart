class CoreModel {
  String? id;
  String? userId;
  String? birthday;
  bool? verified;
  String? fullName;
  int? gender;
  bool? showGenderOnProfile;
  List<int>? sexualOrientations;
  bool? showSexualOrientationOnProfile;
  List<String>? school;
  String? addressName;
  String? bio;
  int? searchingFor;
  int? elo;
  num? distanceInMeters;
  List<Avatars>? avatars;
  AudioMedia? audioMedia;
  List<Interests>? interests;

  CoreModel(
      {this.id,
      this.userId,
      this.birthday,
      this.verified,
      this.fullName,
      this.gender,
      this.showGenderOnProfile,
      this.sexualOrientations,
      this.showSexualOrientationOnProfile,
      this.school,
      this.addressName,
      this.bio,
      this.searchingFor,
      this.elo,
      this.distanceInMeters,
      this.avatars,
      this.audioMedia,
      this.interests});

  CoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    birthday = json['birthday'];
    verified = json['verified'];
    fullName = json['fullName'];
    gender = json['gender'];
    showGenderOnProfile = json['showGenderOnProfile'];
    sexualOrientations = json['sexualOrientations'].cast<int>();
    showSexualOrientationOnProfile = json['showSexualOrientationOnProfile'];
    school = json['school'].cast<String>();
    addressName = json['addressName'];
    bio = json['bio'];
    searchingFor = json['searchingFor'];
    elo = json['elo'];
    distanceInMeters = json['distanceInMeters'];
    if (json['avatars'] != null) {
      avatars = <Avatars>[];
      json['avatars'].forEach((v) {
        avatars!.add(new Avatars.fromJson(v));
      });
    }
    audioMedia = json['audioMedia'] != null
        ? new AudioMedia.fromJson(json['audioMedia'])
        : null;
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['birthday'] = this.birthday;
    data['verified'] = this.verified;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['showGenderOnProfile'] = this.showGenderOnProfile;
    data['sexualOrientations'] = this.sexualOrientations;
    data['showSexualOrientationOnProfile'] =
        this.showSexualOrientationOnProfile;
    data['school'] = this.school;
    data['addressName'] = this.addressName;
    data['bio'] = this.bio;
    data['searchingFor'] = this.searchingFor;
    data['elo'] = this.elo;
    data['distanceInMeters'] = this.distanceInMeters;
    if (this.avatars != null) {
      data['avatars'] = this.avatars!.map((v) => v.toJson()).toList();
    }
    if (this.audioMedia != null) {
      data['audioMedia'] = this.audioMedia!.toJson();
    }
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avatars {
  String? url;
  String? id;
  String? key;
  String? contentType;
  String? bucket;

  Avatars({this.url, this.id, this.key, this.contentType, this.bucket});

  Avatars.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
    key = json['key'];
    contentType = json['content_type'];
    bucket = json['bucket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['id'] = this.id;
    data['key'] = this.key;
    data['content_type'] = this.contentType;
    data['bucket'] = this.bucket;
    return data;
  }
}

class AudioMedia {
  String? url;
  String? id;
  String? key;
  String? contentType;
  String? bucket;

  AudioMedia({this.url, this.id, this.key, this.contentType, this.bucket});

  AudioMedia.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
    key = json['key'];
    contentType = json['content_type'];
    bucket = json['bucket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['id'] = this.id;
    data['key'] = this.key;
    data['content_type'] = this.contentType;
    data['bucket'] = this.bucket;
    return data;
  }
}

class Interests {
  int? id;
  List<UserDescriptorChoice>? userDescriptorChoice;

  Interests({this.id, this.userDescriptorChoice});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['user_descriptor_choice'] != null) {
      userDescriptorChoice = <UserDescriptorChoice>[];
      json['user_descriptor_choice'].forEach((v) {
        userDescriptorChoice!.add(new UserDescriptorChoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userDescriptorChoice != null) {
      data['user_descriptor_choice'] =
          this.userDescriptorChoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDescriptorChoice {
  int? choiceId;

  UserDescriptorChoice({this.choiceId});

  UserDescriptorChoice.fromJson(Map<String, dynamic> json) {
    choiceId = json['choiceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choiceId'] = this.choiceId;
    return data;
  }
}
