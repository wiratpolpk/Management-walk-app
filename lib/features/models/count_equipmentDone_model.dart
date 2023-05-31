class EquipmentDoneModel {
  int? countEquipmentDone;

  EquipmentDoneModel({
    this.countEquipmentDone,
  });

  EquipmentDoneModel.fromJson(Map<String, dynamic> json) {
    countEquipmentDone = json["countEquipmentDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countEquipmentDone'] = countEquipmentDone.toString();
    return data;
  }
}
