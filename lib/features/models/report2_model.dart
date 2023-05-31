class Report2Model {
  int? id;
  String? category;
  int? countOfNo;

  Report2Model({
    this.id,
    this.category,
    this.countOfNo,
  });

  factory Report2Model.fromJson(Map<String, dynamic> json) {
    return Report2Model(
      id: json["id"],
      category: json["category"],
      countOfNo: json['countOfNo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['category'] = category;
    data['countOfNo'] = countOfNo.toString();
    return data;
  }
}
