// To parse this JSON data, do
//
//     final disasterResponse = disasterResponseFromJson(jsonString);

import 'dart:convert';

DisasterResponse disasterResponseFromJson(String str) =>
    DisasterResponse.fromJson(json.decode(str));

String disasterResponseToJson(DisasterResponse data) =>
    json.encode(data.toJson());

class DisasterResponse {
  DisasterResponse({
    this.message,
    this.data,
  });

  String? message;
  List<DisasterData>? data;

  factory DisasterResponse.fromJson(Map<String, dynamic> json) =>
      DisasterResponse(
        message: json["message"],
        data: List<DisasterData>.from(
            json["data"].map((x) => DisasterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DisasterData {
  DisasterData({
    this.id,
    this.type,
    this.subtype,
    this.date,
    this.latitude,
    this.longitude,
    this.casuality,
    this.level,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? subtype;
  DateTime? date;
  int? casuality;
  double? latitude;
  double? longitude;
  String? level;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DisasterData.fromJson(Map<String, dynamic> json) => DisasterData(
        id: json["id"],
        type: json["type"],
        subtype: json["subtype"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        casuality: json["casuality"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        level: json["level"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "type": type,
        "subtype": subtype,
        "date": date,
        "latitude": latitude,
        "longitude": longitude,
        "casuality": casuality,
        "level": level,
      };
}
