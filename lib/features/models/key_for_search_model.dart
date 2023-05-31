import 'dart:convert';

class KeyForSearchModel {
  static final String keyID = 'keyID';
  static final String runID = 'runID';

  static List<String> getFields() => [
        keyID,
        runID,
      ];
}

class KeyForSearch {
  final String? keyID;
  final int runID;

  const KeyForSearch({
    this.keyID,
    required this.runID,
  });

  KeyForSearch copy({
    String? keyID,
    int? runID,
  }) =>
      KeyForSearch(keyID: keyID ?? this.keyID, runID: runID ?? this.runID);

  static KeyForSearch fromJson(Map<String, dynamic> json) => KeyForSearch(
        keyID: json[KeyForSearchModel.keyID],
        runID: jsonDecode(json[KeyForSearchModel.runID]),
      );

  Map<String, dynamic> toJson() => {
        KeyForSearchModel.keyID: keyID,
        KeyForSearchModel.runID: runID,
      };
}
