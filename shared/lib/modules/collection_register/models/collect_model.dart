// To parse this JSON data, do
//
//     final collectResponse = collectResponseFromJson(jsonString);

import 'dart:convert';

CollectionResponse collectResponseFromJson(String str) =>
    CollectionResponse.fromJson(json.decode(str));

String collectResponseToJson(CollectionResponse data) =>
    json.encode(data.toJson());

class CollectionResponse {
  CollectionResponse({
    this.message,
    this.collectData,
  });

  String? message;
  List<CollectionData>? collectData;

  factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
      CollectionResponse(
        message: json["message"],
        collectData: List<CollectionData>.from(
            json["data"].map((x) => CollectionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "collectData": List<dynamic>.from(collectData!.map((x) => x.toJson())),
      };
}

class CollectionData {
  CollectionData({
    this.id,
    this.type,
    this.address,
    this.latitude,
    this.longitude,
    this.date,
    this.description,
    this.photo,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? address;
  double? latitude;
  double? longitude;
  DateTime? date;
  String? description;
  String? photo;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CollectionData.fromJson(Map<String, dynamic> json) => CollectionData(
        id: json["id"],
        type: json["type"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        date: DateTime.parse(json["date"]),
        description: json["description"],
        photo: json["photo"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "description": description,
        "photo": photo,
        "ppid": ppid,
        "psid": psid,
      };
}
