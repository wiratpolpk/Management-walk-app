class LastRunID {
  final String? lastRunID;

  const LastRunID(
    this.lastRunID,
  );

  factory LastRunID.fromJson(Map<String, dynamic> json) => LastRunID(
        json["lastRunID"].toString(),
      );

  Map<String, dynamic> toJson() => {
        'lastRunID': lastRunID.toString(),
      };
}
