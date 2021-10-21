// To parse this JSON data, do
//
//     final missingResponse = missingResponseFromJson(jsonString);

import 'dart:convert';

MissingResponse missingResponseFromJson(String str) =>
    MissingResponse.fromJson(json.decode(str));

String missingResponseToJson(MissingResponse data) =>
    json.encode(data.toJson());

class MissingResponse {
  MissingResponse({
    this.message,
    this.data,
  });

  String? message;
  List<MissingData>? data;

  factory MissingResponse.fromJson(Map<String, dynamic> json) =>
      MissingResponse(
        message: json["message"],
        data: List<MissingData>.from(
            json["data"].map((x) => MissingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MissingData {
  MissingData({
    this.id,
    this.isAdult,
    this.name,
    this.age,
    this.gender,
    this.aadhar,
    this.photo,
    this.address,
    this.latitude,
    this.longitude,
    this.missingDate,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  bool? isAdult;
  String? name;
  int? age;
  String? gender;
  String? aadhar;
  String? photo;
  String? address;
  double? latitude;
  double? longitude;
  DateTime? missingDate;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MissingData.fromJson(Map<String, dynamic> json) => MissingData(
        id: json["id"],
        isAdult: json["isadult"] == 1 ? true : false,
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        aadhar: json["aadhar"],
        photo: json["photo"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        missingDate: json["missingdate"] == null
            ? null
            : DateTime.parse(json["missingdate"]),
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "isadult": isAdult! ? 1 : 0,
        "name": name,
        "age": age,
        "gender": gender,
        "aadhar": aadhar,
        "photo": photo,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
    "missingdate": missingDate
      };
}
