class GmpModel {
  String? questionID;
  String? questionDesc;

  GmpModel({
    this.questionID,
    this.questionDesc,
  });

  GmpModel.fromJson(Map<String, dynamic> json) {
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
