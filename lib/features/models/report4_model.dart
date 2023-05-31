class Report4Model {
  int? id;
  String? section;
  int? countOfNo;

  Report4Model({
    this.id,
    this.section,
    this.countOfNo,
  });

  factory Report4Model.fromJson(Map<String, dynamic> json) {
    return Report4Model(
      id: json["id"],
      section: json["section"],
      countOfNo: json['countOfNo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['section'] = section;
    data['countOfNo'] = countOfNo.toString();
    return data;
  }
}
