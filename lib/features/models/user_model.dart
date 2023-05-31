class User {
  final String? id;
  final String? supervisorName;
  final String? section;
  final String? area;
  final String? startDate;

  const User(
    this.id,
    this.supervisorName,
    this.section,
    this.area,
    this.startDate,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["id"].toString(),
        json["supervisorName"],
        json["sectioin"],
        json["area"],
        json["startDate"],
      );

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'supervisorName': supervisorName,
        'section': section,
        'area': area,
        'startDate': startDate,
      };
}
