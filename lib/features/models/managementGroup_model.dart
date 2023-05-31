class ManagementModel {
  String? questionID;
  String? questionDesc;

  ManagementModel({
    this.questionID,
    this.questionDesc,
  });

  ManagementModel.fromJson(Map<String, dynamic> json) {
    questionID = json["questionID"].toString();
    questionDesc = json["questionDesc"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionID'] = questionID.toString();
    data['supervisorName'] = questionDesc;
    return data;
  }
}
