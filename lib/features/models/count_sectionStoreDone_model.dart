class SectionStoreDoneModel {
  int? countSectionStoreDone;

  SectionStoreDoneModel({
    this.countSectionStoreDone,
  });

  SectionStoreDoneModel.fromJson(Map<String, dynamic> json) {
    countSectionStoreDone = json["countSectionStoreDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countSectionStoreDone'] = countSectionStoreDone.toString();
    return data;
  }
}
