// To parse this JSON data, do
//
//     final placeResponse = placeResponseFromJson(jsonString);

import 'dart:convert';

PlaceResponse placeResponseFromJson(String str) =>
    PlaceResponse.fromJson(json.decode(str));

String placeResponseToJson(PlaceResponse data) => json.encode(data.toJson());

class PlaceResponse {
  PlaceResponse({
    this.message,
    this.data,
  });

  String? message;
  List<PlaceData>? data;

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => PlaceResponse(
        message: json["message"],
        data: List<PlaceData>.from(
            json["data"].map((x) => PlaceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PlaceData {
  PlaceData({
    this.id,
    this.place,
    this.address,
    this.latitude,
    this.longitude,
    this.photo,
    this.isCCTV,
    this.isIssue,
    this.issueReason,
    this.issueCondition,
    this.isCrimeRegistered,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? place;
  String? address;
  double? latitude;
  double? longitude;
  String? photo;
  bool? isCCTV;
  bool? isIssue;
  String? issueReason;
  String? issueCondition;
  bool? isCrimeRegistered;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PlaceData.fromJson(Map<String, dynamic> json) => PlaceData(
        id: json["id"],
        place: json["place"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        photo: json["photo"],
        isCCTV: json["iscctv"] == 1 ? true : false,
        isIssue: json["isissue"] == 1 ? true : false,
        issueReason: json["issuereason"],
        issueCondition: json["issuecondition"],
        isCrimeRegistered: json["crimeregisterd"] == 1 ? true : false,
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "place": place,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "photo": photo,
        "iscctv": isCCTV! ? 1 : 0,
        "isissue": isIssue! ? 1 : 0,
        "issuereason": issueReason,
        "issuecondition": issueCondition,
        "crimeregisterd": isCrimeRegistered! ? 1 : 0,
        "ppid": ppid,
        "psid": psid
      };
}
