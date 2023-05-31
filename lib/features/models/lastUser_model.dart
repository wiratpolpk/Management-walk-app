class LastUser {
  final String? lastUser;

  const LastUser(
    this.lastUser,
  );

  factory LastUser.fromJson(Map<String, dynamic> json) => LastUser(
        json["lastUser"].toString(),
      );

  Map<String, dynamic> toJson() => {
        'lastUser': lastUser.toString(),
      };
}
