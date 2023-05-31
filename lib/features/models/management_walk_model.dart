class ManagementWalk {
  final String? runID;
  final String? keyID;
  final String? supervisorName;
  final String? section;
  final String? area;
  final String? startDate;
  final String? finishedDate;
  final String? questionID;
  final String? questionDesc;
  final String? workCommitmentGroup;
  final String? categoryGroup1;
  final String? categoryGroup2;
  final String? yesChecked;
  final String? noChecked;
  final String? notApplyChecked;
  final String? comment;
  final String? imageUrl;

  const ManagementWalk(
    this.runID,
    this.keyID,
    this.supervisorName,
    this.section,
    this.area,
    this.startDate,
    this.finishedDate,
    this.questionID,
    this.questionDesc,
    this.workCommitmentGroup,
    this.categoryGroup1,
    this.categoryGroup2,
    this.yesChecked,
    this.noChecked,
    this.notApplyChecked,
    this.comment,
    this.imageUrl,
  );

  factory ManagementWalk.fromJson(Map<String, dynamic> json) => ManagementWalk(
        json["runID"].toString(),
        json["keyID"],
        json["supervisorName"],
        json["sectioin"],
        json["area"],
        json["startDate"],
        json["finishedDate"],
        json["questionID"].toString(),
        json["questionDesc"],
        json["workCommitmentGroup"],
        json["categoryGroup1"],
        json["categoryGroup2"],
        json["yesChecked"].toString(),
        json["noChecked"].toString(),
        json["notApplyChecked"].toString(),
        json["comment"],
        json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        'runID': runID.toString(),
        'keyID': keyID,
        'supervisorName': supervisorName,
        'section': section,
        'area': area,
        'startDate': startDate,
        'finishedDate': finishedDate,
        'questionID': questionID,
        'questionDesc': questionDesc,
        'workCommitmentGroup': workCommitmentGroup,
        'categoryGroup1': categoryGroup1,
        'categoryGroup2': categoryGroup2,
        'yesChecked': yesChecked,
        'noChecked': noChecked,
        'notApplyChecked': notApplyChecked,
        'comment': comment,
        'imageUrl': imageUrl,
      };
}
