class SupervisorModel {
  String? supervisorID;
  String? supervisorName;

  SupervisorModel({
    this.supervisorID,
    this.supervisorName,
  });

  SupervisorModel.fromJson(Map<String, dynamic> json) {
    supervisorID = json["supervisorID"].toString();
    supervisorName = json["supervisorName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supervisorID'] = supervisorID.toString();
    data['supervisorName'] = supervisorName;
    return data;
  }
}
