class SafetyDoneModel {
  int? countSafetyDone;

  SafetyDoneModel({
    this.countSafetyDone,
  });

  SafetyDoneModel.fromJson(Map<String, dynamic> json) {
    countSafetyDone = json["countSafetyDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countSafetyDone'] = countSafetyDone.toString();
    return data;
  }
}
