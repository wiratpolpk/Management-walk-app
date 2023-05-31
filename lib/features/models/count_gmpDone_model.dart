class GmpDoneModel {
  int? countGmpDone;

  GmpDoneModel({
    this.countGmpDone,
  });

  GmpDoneModel.fromJson(Map<String, dynamic> json) {
    countGmpDone = json["countGmpDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countGmpDone'] = countGmpDone.toString();
    return data;
  }
}
