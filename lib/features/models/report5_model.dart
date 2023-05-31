class Report5Model {
  int? id;
  String? workCommitment;
  int? countOfYes;

  Report5Model({
    this.id,
    this.workCommitment,
    this.countOfYes,
  });

  factory Report5Model.fromJson(Map<String, dynamic> json) {
    return Report5Model(
      id: json["id"],
      workCommitment: json["workCommitment"],
      countOfYes: json['countOfYes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['workCommitment'] = workCommitment;
    data['countOfYes'] = countOfYes.toString();
    return data;
  }
}
