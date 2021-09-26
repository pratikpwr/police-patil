// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.user,
    required this.accessToken,
  });

  UserClass user;
  String accessToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: UserClass.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.village,
    required this.address,
    required this.joindate,
    required this.enddate,
    required this.psdistance,
    required this.photo,
    required this.latitude,
    required this.longitude,
    required this.psid,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  int mobile;
  String village;
  String address;
  DateTime joindate;
  DateTime enddate;
  double psdistance;
  String photo;
  double latitude;
  double longitude;
  int psid;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        village: json["village"],
        address: json["address"],
        joindate: DateTime.parse(json["joindate"]),
        enddate: DateTime.parse(json["enddate"]),
        psdistance: json["psdistance"].toDouble(),
        photo: json["photo"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "village": village,
        "address": address,
        "joindate": joindate.toIso8601String(),
        "enddate": enddate.toIso8601String(),
        "psdistance": psdistance,
        "photo": photo,
        "latitude": latitude,
        "longitude": longitude,
        "psid": psid,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
