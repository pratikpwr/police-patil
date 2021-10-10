class KayadeResponse {
  KayadeResponse({
    this.message,
    this.data,
  });

  String? message;
  List<KayadeData>? data;

  factory KayadeResponse.fromJson(Map<String, dynamic> json) => KayadeResponse(
        message: json["message"],
        data: List<KayadeData>.from(
            json["data"].map((x) => KayadeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class KayadeData {
  KayadeData({
    this.id,
    this.title,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory KayadeData.fromJson(Map<String, dynamic> json) => KayadeData(
        id: json["id"],
        title: json["title"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "file": file,
      };
}
