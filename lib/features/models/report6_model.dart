class Report6Model {
  int? id;
  String? workCommitment;
  int? countOfNo;

  Report6Model({
    this.id,
    this.workCommitment,
    this.countOfNo,
  });

  factory Report6Model.fromJson(Map<String, dynamic> json) {
    return Report6Model(
      id: json["id"],
      workCommitment: json["workCommitment"],
      countOfNo: json['countOfNo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['workCommitment'] = workCommitment;
    data['countOfNo'] = countOfNo.toString();
    return data;
  }
}
