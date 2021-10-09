// To parse this JSON data, do
//
//     final helperResponse = helperResponseFromJson(jsonString);

import 'dart:convert';

HelperResponse helperResponseFromJson(String str) =>
    HelperResponse.fromJson(json.decode(str));

String helperResponseToJson(HelperResponse data) => json.encode(data.toJson());

class HelperResponse {
  HelperResponse({
    this.message,
    this.data,
  });

  String? message;
  List<HelperData>? data;

  factory HelperResponse.fromJson(Map<String, dynamic> json) => HelperResponse(
        message: json["message"],
        data: List<HelperData>.from(
            json["data"].map((x) => HelperData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HelperData {
  HelperData({
    this.id,
    this.name,
    this.skill,
    this.mobile,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? skill;
  int? mobile;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HelperData.fromJson(Map<String, dynamic> json) => HelperData(
        id: json["id"],
        name: json["name"],
        skill: json["skill"],
        mobile: json["mobile"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "skill": skill,
        "mobile": mobile,
        "ppid": ppid,
        "psid": psid
      };
}
