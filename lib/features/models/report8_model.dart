class Report8Model {
  int? id;
  String? supervisorName;
  int? notApplyChecked;

  Report8Model({
    this.id,
    this.supervisorName,
    this.notApplyChecked,
  });

  factory Report8Model.fromJson(Map<String, dynamic> json) {
    return Report8Model(
      id: json["id"],
      supervisorName: json["supervisorName"],
      notApplyChecked: json['notApplyChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['supervisorName'] = supervisorName;
    data['notApplyChecked'] = notApplyChecked.toString();
    return data;
  }
}
