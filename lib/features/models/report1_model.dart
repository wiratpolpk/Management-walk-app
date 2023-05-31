class Report1Model {
  int? id;
  String? category;
  int? countOfYes;

  Report1Model({
    this.id,
    this.category,
    this.countOfYes,
  });

  factory Report1Model.fromJson(Map<String, dynamic> json) {
    return Report1Model(
      id: json["id"],
      category: json["category"],
      countOfYes: json['countOfYes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['category'] = category;
    data['countOfYes'] = countOfYes.toString();
    return data;
  }
}
