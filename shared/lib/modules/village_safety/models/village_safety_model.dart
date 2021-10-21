class VillageSafetyResponse {
  VillageSafetyResponse({
    this.message,
    this.data,
  });

  String? message;
  List<VillageSafetyData>? data;

  factory VillageSafetyResponse.fromJson(Map<String, dynamic> json) =>
      VillageSafetyResponse(
        message: json["message"],
        data: List<VillageSafetyData>.from(
            json["data"].map((x) => VillageSafetyData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VillageSafetyData {
  VillageSafetyData({
    this.id,
    this.name,
    this.skill,
    this.mobile,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? skill;
  int? mobile;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory VillageSafetyData.fromJson(Map<String, dynamic> json) =>
      VillageSafetyData(
        id: json["id"],
        name: json["name"],
        skill: json["skill"],
        mobile: json["mobile"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "skill": skill,
        "mobile": mobile,
        "ppid": ppid,
        "psid": psid
      };
}
