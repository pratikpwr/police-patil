// To parse this JSON data, do
//
//     final alertResponse = alertResponseFromJson(jsonString);

import 'dart:convert';

class NewsResponse {
  NewsResponse({
    this.message,
    this.data,
  });

  String? message;
  List<NewsData>? data;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        message: json["message"],
        data:
            List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NewsData {
  NewsData({
    this.id,
    this.title,
    this.date,
    this.link,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  DateTime? date;
  String? link;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        id: json["id"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "link": link,
        "file": file,
      };
}
