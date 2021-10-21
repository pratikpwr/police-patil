// To parse this JSON data, do
//
//     final watchResponse = watchResponseFromJson(jsonString);

import 'dart:convert';

WatchResponse watchResponseFromJson(String str) =>
    WatchResponse.fromJson(json.decode(str));

String watchResponseToJson(WatchResponse data) => json.encode(data.toJson());

class WatchResponse {
  WatchResponse({
    this.message,
    this.data,
  });

  String? message;
  List<WatchData>? data;

  factory WatchResponse.fromJson(Map<String, dynamic> json) => WatchResponse(
        message: json["message"],
        data: List<WatchData>.from(
            json["data"].map((x) => WatchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WatchData {
  WatchData({
    this.id,
    this.type,
    this.name,
    this.mobile,
    this.photo,
    this.aadhar,
    this.address,
    this.latitude,
    this.longitude,
    this.description,
    this.otherPhoto,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? name;
  int? mobile;
  String? photo;
  String? aadhar;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  String? otherPhoto;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory WatchData.fromJson(Map<String, dynamic> json) => WatchData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        mobile: json["mobile"],
        photo: json["photo"],
        aadhar: json["aadhar"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        description: json["description"],
        otherPhoto: json["otherphoto"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "mobile": mobile,
        "photo": photo,
        "aadhar": aadhar,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
        "ppid": ppid,
        "psid": psid,
      };
}
