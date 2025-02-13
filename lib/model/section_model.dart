
class SectionModel {
  int? id;
  int? status;
  String? name;
  String? prompt;
  int? displayType;
  int? sectionType;
  int? onboardIndex;
  String? onboardPrompt;
  String? onboardSubPrompt;
  String? updatedAt;
  List<Descriptors>? descriptors;

  SectionModel(
      {this.id,
        this.status,
        this.name,
        this.prompt,
        this.displayType,
        this.sectionType,
        this.onboardIndex,
        this.onboardPrompt,
        this.onboardSubPrompt,
        this.updatedAt,
        this.descriptors});

  SectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    prompt = json['prompt'];
    displayType = json['display_type'];
    sectionType = json['section_type'];
    onboardIndex = json['onboardIndex'];
    onboardPrompt = json['onboardPrompt'];
    onboardSubPrompt = json['onboardSubPrompt'];
    updatedAt = json['updatedAt'];
    if (json['descriptors'] != null) {
      descriptors = <Descriptors>[];
      json['descriptors'].forEach((v) {
        descriptors!.add(new Descriptors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['prompt'] = this.prompt;
    data['display_type'] = this.displayType;
    data['section_type'] = this.sectionType;
    data['onboardIndex'] = this.onboardIndex;
    data['onboardPrompt'] = this.onboardPrompt;
    data['onboardSubPrompt'] = this.onboardSubPrompt;
    data['updatedAt'] = this.updatedAt;
    if (this.descriptors != null) {
      data['descriptors'] = this.descriptors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Descriptors {
  int? id;
  int? status;
  int? sectionId;
  String? prompt;
  Null? subPrompt;
  String? name;
  int? type;
  String? iconUrl;
  String? matchGroupKey;
  String? backgroundText;
  int? onboardIndex;
  int? maxSelections;
  int? minSelections;
  bool? enableSearch;
  String? updatedAt;
  List<Choices>? choices;
  List<MeasurableDetails>? measurableDetails;

  Descriptors(
      {this.id,
        this.status,
        this.sectionId,
        this.prompt,
        this.subPrompt,
        this.name,
        this.type,
        this.iconUrl,
        this.matchGroupKey,
        this.backgroundText,
        this.onboardIndex,
        this.maxSelections,
        this.minSelections,
        this.enableSearch,
        this.updatedAt,
        this.choices,
        this.measurableDetails});

  Descriptors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sectionId = json['section_id'];
    prompt = json['prompt'];
    subPrompt = json['sub_prompt'];
    name = json['name'];
    type = json['type'];
    iconUrl = json['icon_url'];
    matchGroupKey = json['match_group_key'];
    backgroundText = json['background_text'];
    onboardIndex = json['onboardIndex'];
    maxSelections = json['max_selections'];
    minSelections = json['min_selections'];
    enableSearch = json['enableSearch'];
    updatedAt = json['updatedAt'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    if (json['measurable_details'] != null) {
      measurableDetails = <MeasurableDetails>[];
      json['measurable_details'].forEach((v) {
        measurableDetails!.add(new MeasurableDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['section_id'] = this.sectionId;
    data['prompt'] = this.prompt;
    data['sub_prompt'] = this.subPrompt;
    data['name'] = this.name;
    data['type'] = this.type;
    data['icon_url'] = this.iconUrl;
    data['match_group_key'] = this.matchGroupKey;
    data['background_text'] = this.backgroundText;
    data['onboardIndex'] = this.onboardIndex;
    data['max_selections'] = this.maxSelections;
    data['min_selections'] = this.minSelections;
    data['enableSearch'] = this.enableSearch;
    data['updatedAt'] = this.updatedAt;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    if (this.measurableDetails != null) {
      data['measurable_details'] =
          this.measurableDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  int? id;
  int? status;
  int? descriptorId;
  String? name;
  Null? style;
  Null? emoji;
  String? matchGroupKey;
  String? updatedAt;

  Choices(
      {this.id,
        this.status,
        this.descriptorId,
        this.name,
        this.style,
        this.emoji,
        this.matchGroupKey,
        this.updatedAt});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    descriptorId = json['descriptor_id'];
    name = json['name'];
    style = json['style'];
    emoji = json['emoji'];
    matchGroupKey = json['match_group_key'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['descriptor_id'] = this.descriptorId;
    data['name'] = this.name;
    data['style'] = this.style;
    data['emoji'] = this.emoji;
    data['match_group_key'] = this.matchGroupKey;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class MeasurableDetails {
  int? id;
  int? status;
  int? descriptorId;
  int? minValue;
  int? maxValue;
  String? defaultUnitOfMeasure;
  String? unitOfMeasure;
  String? updatedAt;

  MeasurableDetails(
      {this.id,
        this.status,
        this.descriptorId,
        this.minValue,
        this.maxValue,
        this.defaultUnitOfMeasure,
        this.unitOfMeasure,
        this.updatedAt});

  MeasurableDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    descriptorId = json['descriptor_id'];
    minValue = json['min_value'];
    maxValue = json['max_value'];
    defaultUnitOfMeasure = json['default_unit_of_measure'];
    unitOfMeasure = json['unit_of_measure'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['descriptor_id'] = this.descriptorId;
    data['min_value'] = this.minValue;
    data['max_value'] = this.maxValue;
    data['default_unit_of_measure'] = this.defaultUnitOfMeasure;
    data['unit_of_measure'] = this.unitOfMeasure;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
