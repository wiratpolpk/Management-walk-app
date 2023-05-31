class EquipmentModel {
  String? questionID;
  String? questionDesc;

  EquipmentModel({
    this.questionID,
    this.questionDesc,
  });

  EquipmentModel.fromJson(Map<String, dynamic> json) {
    questionID = json["questionID"].toString();
    questionDesc = json["questionDesc"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionID'] = questionID.toString();
    data['questionDesc'] = questionDesc;
    return data;
  }
}
