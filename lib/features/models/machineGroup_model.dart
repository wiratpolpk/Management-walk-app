class MachineModel {
  String? questionID;
  String? questionDesc;

  MachineModel({
    this.questionID,
    this.questionDesc,
  });

  MachineModel.fromJson(Map<String, dynamic> json) {
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
