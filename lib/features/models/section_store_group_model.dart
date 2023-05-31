import 'dart:convert';

class SectionStoreGroupModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';

  static List<String> getFields() => [questionID, questionDesc];
}

class SectionStoreGroup {
  final int? questionID;
  final String questionDesc;

  const SectionStoreGroup({
    this.questionID,
    required this.questionDesc,
  });

  static SectionStoreGroup fromJson(Map<String, dynamic> json) =>
      SectionStoreGroup(
        questionID: jsonDecode(json[SectionStoreGroupModel.questionID]),
        questionDesc: json[SectionStoreGroupModel.questionDesc],
      );

  Map<String, dynamic> toJson() => {
        SectionStoreGroupModel.questionID: questionID,
        SectionStoreGroupModel.questionDesc: questionDesc,
      };
}
