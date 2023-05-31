class Report7Model {
  int? id;
  String? supervisorName;
  int? week1;
  int? week2;
  int? week3;
  int? week4;

  Report7Model({
    this.id,
    this.supervisorName,
    this.week1,
    this.week2,
    this.week3,
    this.week4,
  });

  factory Report7Model.fromJson(Map<String, dynamic> json) {
    return Report7Model(
      id: json["id"],
      supervisorName: json["supervisorName"],
      week1: json['week1'],
      week2: json['week2'],
      week3: json['week3'],
      week4: json['week4'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['supervisorName'] = supervisorName;
    data['week1'] = week1.toString();
    data['week2'] = week2.toString();
    data['week3'] = week3.toString();
    data['week4'] = week4.toString();
    return data;
  }
}
