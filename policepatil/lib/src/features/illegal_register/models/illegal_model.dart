// To parse this JSON data, do
//
//     final illegalResponse = illegalResponseFromJson(jsonString);

import 'dart:convert';

IllegalResponse illegalResponseFromJson(String str) =>
    IllegalResponse.fromJson(json.decode(str));

class IllegalResponse {
  IllegalResponse({
    this.message,
    this.data,
  });

  String? message;
  List<IllegalData>? data;

  factory IllegalResponse.fromJson(Map<String, dynamic> json) =>
      IllegalResponse(
        message: json["message"],
        data: List<IllegalData>.from(
            json["data"].map((x) => IllegalData.fromJson(x))),
      );
}

class IllegalData {
  IllegalData({
    this.id,
    this.type,
    this.name,
    this.photo,
    this.address,
    this.latitude,
    this.longitude,
    this.vehicleNo,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? name;
  dynamic photo;
  String? address;
  double? latitude;
  String? vehicleNo;
  double? longitude;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory IllegalData.fromJson(Map<String, dynamic> json) => IllegalData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        photo: json["photo"],
        vehicleNo: json["vehicle_no"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "type": type,
        "name": name,
        "photo": photo,
        "vehicle_no": vehicleNo,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
