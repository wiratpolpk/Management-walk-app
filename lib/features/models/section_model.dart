import 'dart:convert';

class SectionModel {
  static final String sectionID = 'sectionID';
  static final String sectionDesc = 'sectionDesc';

  static List<String> getFields() => [sectionID, sectionDesc];
}

class Section {
  final String? sectionID;
  final String sectionDesc;

  const Section({
    this.sectionID,
    required this.sectionDesc,
  });

  static Section fromJson(Map<String, dynamic> json) => Section(
        sectionID: json[SectionModel.sectionID].toString(),
        sectionDesc: json[SectionModel.sectionDesc],
      );

  Map<String, dynamic> toJson() => {
        SectionModel.sectionID: sectionID,
        SectionModel.sectionDesc: sectionDesc,
      };
}
