// To parse this JSON data, do
//
//     final crimeResponse = crimeResponseFromJson(jsonString);

import 'dart:convert';

CrimeResponse crimeResponseFromJson(String str) =>
    CrimeResponse.fromJson(json.decode(str));

String crimeResponseToJson(CrimeResponse data) => json.encode(data.toJson());

class CrimeResponse {
  CrimeResponse({
    this.message,
    this.data,
  });

  String? message;
  List<CrimeData>? data;

  factory CrimeResponse.fromJson(Map<String, dynamic> json) => CrimeResponse(
        message: json["message"],
        data: List<CrimeData>.from(
            json["data"].map((x) => CrimeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CrimeData {
  CrimeData({
    this.id,
    this.type,
    this.registerNumber,
    this.date,
    this.time,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? registerNumber;
  DateTime? date;
  String? time;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CrimeData.fromJson(Map<String, dynamic> json) => CrimeData(
        id: json["id"],
        type: json["type"],
        registerNumber: json["registernumber"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "registernumber": registerNumber,
        "date": date,
        "time": time,
      };
}
