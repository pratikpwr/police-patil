class UserData {
  UserData({
    required this.id,
    required this.token,
  });

  int id;
  String token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
      };
}
