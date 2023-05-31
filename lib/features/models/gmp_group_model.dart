import 'dart:convert';

class GMPGroupModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';

  static List<String> getFields() => [questionID, questionDesc];
}

class GMPGroup {
  final int? questionID;
  final String questionDesc;

  const GMPGroup({
    this.questionID,
    required this.questionDesc,
  });

  static GMPGroup fromJson(Map<String, dynamic> json) => GMPGroup(
        questionID: jsonDecode(json[GMPGroupModel.questionID]),
        questionDesc: json[GMPGroupModel.questionDesc],
      );

  Map<String, dynamic> toJson() => {
        GMPGroupModel.questionID: questionID,
        GMPGroupModel.questionDesc: questionDesc,
      };
}
