// To parse this JSON data, do
//
//     final movementResponse = movementResponseFromJson(jsonString);

import 'dart:convert';

MovementResponse movementResponseFromJson(String str) =>
    MovementResponse.fromJson(json.decode(str));

String movementResponseToJson(MovementResponse data) =>
    json.encode(data.toJson());

class MovementResponse {
  MovementResponse({
    this.message,
    this.movementData,
  });

  String? message;
  List<MovementData>? movementData;

  factory MovementResponse.fromJson(Map<String, dynamic> json) =>
      MovementResponse(
        message: json["message"],
        movementData: List<MovementData>.from(
            json["data"].map((x) => MovementData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(movementData!.map((x) => x.toJson())),
      };
}

class MovementData {
  MovementData({
    this.id,
    this.type,
    this.subtype,
    this.address,
    this.latitude,
    this.longitude,
    this.datetime,
    this.issue,
    this.attendance,
    this.description,
    this.photo,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? subtype;
  String? address;
  double? latitude;
  double? longitude;
  DateTime? datetime;
  int? issue;
  int? attendance;
  String? description;
  String? photo;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MovementData.fromJson(Map<String, dynamic> json) => MovementData(
        id: json["id"],
        type: json["type"],
        subtype: json["subtype"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        datetime: DateTime.parse(json["datetime"]),
        issue: json["issue"],
        attendance: json["attendance"],
        description: json["description"],
        photo: json["photo"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "datetime": datetime!.toIso8601String(),
        "issue": issue,
        "attendance": attendance,
        "description": description,
        "photo": photo,
        "ppid": ppid,
        "psid": psid
      };
}
