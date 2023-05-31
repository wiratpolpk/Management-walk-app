class ManagementDoneModel {
  int? countManagementDone;

  ManagementDoneModel({
    this.countManagementDone,
  });

  ManagementDoneModel.fromJson(Map<String, dynamic> json) {
    countManagementDone = json["countManagementDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countManagementDone'] = countManagementDone.toString();
    return data;
  }
}
