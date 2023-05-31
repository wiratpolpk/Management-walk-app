import 'dart:convert';

class WorkCommitmentModel {
  static final String questionID = 'questionID';
  static final String questionDesc = 'questionDesc';
  static final String workCommitment = 'workCommitment';
  static final String group1 = 'group1';
  static final String group2 = 'group2';

  static List<String> getFields() =>
      [questionID, questionDesc, workCommitment, group1, group2];
}

class WorkCommitment {
  final String? questionID;
  final String questionDesc;
  final String workCommitment;
  final String group1;
  final String group2;

  const WorkCommitment({
    this.questionID,
    required this.questionDesc,
    required this.workCommitment,
    required this.group1,
    required this.group2,
  });

  static WorkCommitment fromJson(Map<String, dynamic> json) => WorkCommitment(
        questionID: json[WorkCommitmentModel.questionID].toString(),
        questionDesc: json[WorkCommitmentModel.questionDesc],
        workCommitment: json[WorkCommitmentModel.workCommitment],
        group1: json[WorkCommitmentModel.group1],
        group2: json[WorkCommitmentModel.group2],
      );

  Map<String, dynamic> toJson() => {
        WorkCommitmentModel.questionID: questionID,
        WorkCommitmentModel.questionDesc: questionDesc,
        WorkCommitmentModel.workCommitment: workCommitment,
        WorkCommitmentModel.group1: group1,
        WorkCommitmentModel.group2: group2,
      };
}
