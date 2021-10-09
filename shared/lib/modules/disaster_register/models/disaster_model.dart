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
  String? level;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DisasterData.fromJson(Map<String, dynamic> json) => DisasterData(
        id: json["id"],
        type: json["type"],
        subtype: json["subtype"],
        date: DateTime.parse(json["date"]),
        casuality: json["casuality"],
        level: json["level"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "casuality": casuality,
        "level": level,
        "ppid": ppid,
        "psid": psid,
      };
}
