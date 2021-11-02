// To parse this JSON data, do
//
//     final fireResponse = fireResponseFromJson(jsonString);

import 'dart:convert';

FireResponse fireResponseFromJson(String str) =>
    FireResponse.fromJson(json.decode(str));

String fireResponseToJson(FireResponse data) => json.encode(data.toJson());

class FireResponse {
  FireResponse({
    this.message,
    this.data,
  });

  String? message;
  List<FireData>? data;

  factory FireResponse.fromJson(Map<String, dynamic> json) => FireResponse(
        message: json["message"],
        data:
            List<FireData>.from(json["data"].map((x) => FireData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FireData {
  FireData({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.date,
    this.time,
    this.reason,
    this.loss,
    this.photo,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? address;
  double? latitude;
  double? longitude;
  DateTime? date;
  String? time;
  String? reason;
  String? loss;
  dynamic photo;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory FireData.fromJson(Map<String, dynamic> json) => FireData(
        id: json["id"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        reason: json["reason"],
        loss: json["loss"],
        photo: json["photo"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "date": date,
        "time": time,
        "reason": reason,
        "loss": loss,
    "photo": photo
      };
}
