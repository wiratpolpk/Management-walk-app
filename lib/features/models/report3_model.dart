class Report3Model {
  int? id;
  String? section;
  int? countOfYes;

  Report3Model({
    this.id,
    this.section,
    this.countOfYes,
  });

  factory Report3Model.fromJson(Map<String, dynamic> json) {
    return Report3Model(
      id: json["id"],
      section: json["section"],
      countOfYes: json['countOfYes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['section'] = section;
    data['countOfYes'] = countOfYes.toString();
    return data;
  }
}
