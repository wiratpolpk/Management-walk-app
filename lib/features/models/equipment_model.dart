import 'dart:convert';

class EquipmentGroupModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';

  static List<String> getFields() => [questionID, questionDesc];
}

class EquipmentGroup {
  final int? questionID;
  final String questionDesc;

  const EquipmentGroup({
    this.questionID,
    required this.questionDesc,
  });

  static EquipmentGroup fromJson(Map<String, dynamic> json) => EquipmentGroup(
        questionID: jsonDecode(json[EquipmentGroupModel.questionID]),
        questionDesc: json[EquipmentGroupModel.questionDesc],
      );

  Map<String, dynamic> toJson() => {
        EquipmentGroupModel.questionID: questionID,
        EquipmentGroupModel.questionDesc: questionDesc,
      };
}
