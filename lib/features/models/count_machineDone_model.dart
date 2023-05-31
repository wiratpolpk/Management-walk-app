class MachineDoneModel {
  int? countMachineDone;

  MachineDoneModel({
    this.countMachineDone,
  });

  MachineDoneModel.fromJson(Map<String, dynamic> json) {
    countMachineDone = json["countMachineDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countMachineDone'] = countMachineDone.toString();
    return data;
  }
}
