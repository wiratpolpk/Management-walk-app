import 'dart:convert';

class MachineGroupModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';

  static List<String> getFields() => [questionID, questionDesc];
}

class MachineGroup {
  final int? questionID;
  final String questionDesc;

  const MachineGroup({
    this.questionID,
    required this.questionDesc,
  });

  static MachineGroup fromJson(Map<String, dynamic> json) => MachineGroup(
        questionID: jsonDecode(json[MachineGroupModel.questionID]),
        questionDesc: json[MachineGroupModel.questionDesc],
      );

  Map<String, dynamic> toJson() => {
        MachineGroupModel.questionID: questionID,
        MachineGroupModel.questionDesc: questionDesc,
      };
}
