class ManagementWalkModel {
  String? runID;
  String? keyID;
  String? supervisorName;
  String? section;
  String? area;
  String? startDate;
  String? finishedDate;
  String? questionID;
  String? questionDesc;
  String? workCommitmentGroup;
  String? categoryGroup1;
  String? categoryGroup2;
  String? yesChecked;
  String? noChecked;
  String? notApplyChecked;
  String? comment;
  String? imageUrl;

  ManagementWalkModel({
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
  });

  ManagementWalkModel.fromJson(Map<String, dynamic> json) {
    runID = json["runID"].toString();
    keyID = json["keyID"];
    supervisorName = json["supervisorName"];
    section = json["section"];
    area = json["area"];
    startDate = json["startDate"];
    finishedDate = json["finishedDate"];
    questionID = json["questionID"].toString();
    questionDesc = json["questionDesc"];
    workCommitmentGroup = json["workCommitmentGroup"];
    categoryGroup1 = json["categoryGroup1"];
    categoryGroup2 = json["categoryGroup2"];
    yesChecked = json["yesChecked"].toString();
    noChecked = json["noChecked"].toString();
    notApplyChecked = json["notApplyChecked"].toString();
    comment = json["comment"];
    imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['runID'] = runID.toString();
    data['keyID'] = keyID;
    data['supervisorName'] = supervisorName;
    data['section'] = section;
    data['area'] = area;
    data['startDate'] = startDate;
    data['finishedDate'] = finishedDate;
    data['questionID'] = questionID.toString();
    data['questionDesc'] = questionDesc;
    data['workCommitmentGroup'] = workCommitmentGroup;
    data['categoryGroup1'] = categoryGroup1;
    data['categoryGroup2'] = categoryGroup2;
    data['yesChecked'] = yesChecked;
    data['noChecked'] = noChecked;
    data['notApplyChecked'] = notApplyChecked;
    data['comment'] = comment;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
