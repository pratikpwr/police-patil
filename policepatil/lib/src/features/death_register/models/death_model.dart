// To parse this JSON data, do
//
//     final deathResponse = deathResponseFromJson(jsonString);

import 'dart:convert';

DeathResponse deathResponseFromJson(String str) =>
    DeathResponse.fromJson(json.decode(str));

String deathResponseToJson(DeathResponse data) => json.encode(data.toJson());

class DeathResponse {
  DeathResponse({
    this.message,
    this.data,
  });

  String? message;
  List<DeathData>? data;

  factory DeathResponse.fromJson(Map<String, dynamic> json) => DeathResponse(
        message: json["message"],
        data: List<DeathData>.from(
            json["data"].map((x) => DeathData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DeathData {
  DeathData({
    this.id,
    this.isKnown,
    this.name,
    this.gender,
    this.address,
    this.latitude,
    this.longitude,
    this.photo,
    this.foundAddress,
    this.causeOfDeath,
    this.dateOfDeath,
    this.age,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  bool? isKnown;
  String? name;
  String? gender;
  String? address;
  double? latitude;
  double? longitude;
  dynamic photo;
  String? foundAddress;
  String? causeOfDeath;
  DateTime? dateOfDeath;
  int? age;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DeathData.fromJson(Map<String, dynamic> json) => DeathData(
        id: json["id"],
        isKnown: json["isknown"] == 1 ? true : false,
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        photo: json["photo"],
        foundAddress: json["foundaddress"],
        causeOfDeath: json["causeofdeath"],
        dateOfDeath: json["date"] == null ? null : DateTime.parse(json["date"]),
        age: json["age"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "isknown": isKnown! ? 1 : 0,
        "name": name,
        "gender": gender,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "date": dateOfDeath == null ? null : dateOfDeath!.toIso8601String(),
        "photo": photo,
        "foundaddress": foundAddress,
        "causeofdeath": causeOfDeath,
        "age": age,
      };
}
