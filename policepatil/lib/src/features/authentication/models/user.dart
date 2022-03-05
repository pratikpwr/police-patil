class UserModel {
  UserModel({
    this.user,
    this.accessToken,
  });

  UserClass? user;
  String? accessToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: UserClass.fromJson(json["user"]),
        accessToken: json["access_token"],
      );
}

/// This user class is only for Auth and login
class UserClass {
  UserClass(
      {this.id, this.name, this.email, this.mobile, this.role, this.psid});

  int? id;
  String? name;
  String? email;
  int? mobile;
  String? role;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        mobile: json["mobile"],
        psid: json["psid"],
      );
}
