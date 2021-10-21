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
    this.licenceNumber,
    this.uid,
    this.weaponCondition,
    this.validity,
    this.licencephoto,
    this.ppid,
    this.psid,
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
  String? uid;
  String? weaponCondition;
  DateTime? validity;
  String? licencephoto;
  int? ppid;
  int? psid;

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
        validity:
            json["validity"] == null ? null : DateTime.parse(json["validity"]),
        licencephoto: json["licencephoto"],
        ppid: json["ppid"],
        psid: json["psid"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "mobile": mobile,
        "aadhar": aadhar,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "licencenumber": licenceNumber,
        "uid": uid,
        "weapon_condition": weaponCondition,
        "validity": validity,
        "licencephoto": licencephoto,
      };
}
