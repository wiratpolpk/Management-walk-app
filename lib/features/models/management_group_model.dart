import 'dart:convert';

class ManagementGroupModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';

  static List<String> getFields() => [questionID, questionDesc];
}

class ManagementGroup {
  final int? questionID;
  final String questionDesc;

  const ManagementGroup({
    this.questionID,
    required this.questionDesc,
  });

  static ManagementGroup fromJson(Map<String, dynamic> json) => ManagementGroup(
        questionID: jsonDecode(json[ManagementGroupModel.questionID]),
        questionDesc: json[ManagementGroupModel.questionDesc],
      );

  Map<String, dynamic> toJson() => {
        ManagementGroupModel.questionID: questionID,
        ManagementGroupModel.questionDesc: questionDesc,
      };
}
