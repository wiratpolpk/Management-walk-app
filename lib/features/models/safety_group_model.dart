import 'dart:convert';

class SafetyGroupModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';

  static List<String> getFields() => [questionID, questionDesc];
}

class SafetyGroup {
  final int? questionID;
  final String questionDesc;

  const SafetyGroup({
    this.questionID,
    required this.questionDesc,
  });

  static SafetyGroup fromJson(Map<String, dynamic> json) => SafetyGroup(
        questionID: jsonDecode(json[SafetyGroupModel.questionID]),
        questionDesc: json[SafetyGroupModel.questionDesc],
      );

  Map<String, dynamic> toJson() => {
        SafetyGroupModel.questionID: questionID,
        SafetyGroupModel.questionDesc: questionDesc,
      };
}
