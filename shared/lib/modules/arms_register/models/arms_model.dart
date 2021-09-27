class ArmsResponse {
  ArmsResponse({
    required this.message,
    required this.data,
  });

  String message;
  List<ArmsData> data;

  factory ArmsResponse.fromJson(Map<String, dynamic> json) => ArmsResponse(
        message: json["message"],
        data:
            List<ArmsData>.from(json["data"].map((x) => ArmsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ArmsData {
  ArmsData({
    this.id,
    this.type,
    this.name,
    this.mobile,
    this.aadhar,
    this.address,
    this.latitude,
    this.longitude,
    this.validity,
    this.licencephoto,
    this.licenceNumber,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? name;
  int? mobile;
  String? aadhar;
  String? address;
  double? latitude;
  double? longitude;
  String? licenceNumber;
  DateTime? validity;
  String? licencephoto;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ArmsData.fromJson(Map<String, dynamic> json) => ArmsData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        mobile: json["mobile"],
        aadhar: json["aadhar"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        licenceNumber: json["licencenumber"],
        validity: DateTime.parse(json["validity"]),
        licencephoto: json["licencephoto"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "type": type,
        "name": name,
        "mobile": mobile,
        "aadhar": aadhar,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "licencenumber": licenceNumber,
        "validity":
            "${validity!.year.toString().padLeft(4, '0')}-${validity!.month.toString().padLeft(2, '0')}-${validity!.day.toString().padLeft(2, '0')}",
        "licencephoto": licencephoto,
        "ppid": ppid,
        "psid": psid
      };
}
