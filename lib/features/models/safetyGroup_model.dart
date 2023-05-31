class SafetyModel {
  String? questionID;
  String? questionDesc;

  SafetyModel({
    this.questionID,
    this.questionDesc,
  });

  SafetyModel.fromJson(Map<String, dynamic> json) {
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
