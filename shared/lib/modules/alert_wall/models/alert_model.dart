// To parse this JSON data, do
//
//     final alertResponse = alertResponseFromJson(jsonString);

import 'dart:convert';

AlertResponse alertResponseFromJson(String str) =>
    AlertResponse.fromJson(json.decode(str));

String alertResponseToJson(AlertResponse data) => json.encode(data.toJson());

class AlertResponse {
  AlertResponse({
    this.message,
    this.data,
  });

  String? message;
  List<AlertData>? data;

  factory AlertResponse.fromJson(Map<String, dynamic> json) => AlertResponse(
        message: json["message"],
        data: List<AlertData>.from(
            json["data"].map((x) => AlertData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AlertData {
  AlertData({
    this.id,
    this.title,
    this.date,
    this.photo,
    this.videoLink,
    this.otherLink,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  DateTime? date;
  String? photo;
  String? videoLink;
  String? otherLink;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AlertData.fromJson(Map<String, dynamic> json) => AlertData(
        id: json["id"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        photo: json["photo"],
        videoLink: json["videolink"],
        otherLink: json["otherlink"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "photo": photo,
        "videolink": videoLink,
        "otherlink": otherLink,
        "file": file,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
