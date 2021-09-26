import 'dart:convert';

class ArmsList {
  ArmsList({
    required this.armsData,
  });

  List<ArmsData> armsData;

  factory ArmsList.fromJson(Map<String, dynamic> json) => ArmsList(
        armsData: List<ArmsData>.from(
            json["armsData"].map((x) => ArmsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "armsData": List<dynamic>.from(armsData.map((x) => x.toJson())),
      };
}

class ArmsData {
  ArmsData({
    required this.id,
    required this.type,
    required this.name,
    required this.mobile,
    required this.aadhar,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.validity,
    required this.licencephoto,
    required this.licenceNumber,
    required this.ppid,
    required this.psid,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String type;
  String name;
  int mobile;
  String aadhar;
  String address;
  double latitude;
  double longitude;
  String licenceNumber;
  DateTime validity;
  String licencephoto;
  int ppid;
  int psid;
  DateTime createdAt;
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

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "mobile": mobile,
        "aadhar": aadhar,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "licencenumber": licenceNumber,
        "validity":
            "${validity.year.toString().padLeft(4, '0')}-${validity.month.toString().padLeft(2, '0')}-${validity.day.toString().padLeft(2, '0')}",
        "licencephoto": licencephoto,
        "ppid": ppid,
        "psid": psid
      };
}
