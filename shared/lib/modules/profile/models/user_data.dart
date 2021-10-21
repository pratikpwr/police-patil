/// This user data class is for only user data get and update
class UserData {
  UserData({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.role,
    this.village,
    this.address,
    this.orderNo,
    this.joindate,
    this.enddate,
    this.psdistance,
    this.photo,
    this.latitude,
    this.longitude,
    this.psid,
    this.taluka,
    this.dangerzone,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  int? mobile;
  String? role;
  String? village;
  String? address;
  DateTime? joindate;
  DateTime? enddate;
  int? psdistance;
  String? photo;
  double? latitude;
  double? longitude;
  String? taluka;
  String? dangerzone;
  String? orderNo;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        village: json["village"],
        mobile: json["mobile"],
        address: json["address"],
        orderNo: json["ordernumber"],
        joindate:
            json["joindate"] == null ? null : DateTime.parse(json["joindate"]),
        enddate:
            json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        psdistance: json["psdistance"],
        photo: json["photo"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        psid: json["psid"],
        taluka: json["taluka"],
        dangerzone: json["dangerzone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        // "email": email,
        // "village": village,
        "mobile": mobile,
        "address": address,
        "joindate": joindate,
        "enddate": enddate,
        "psdistance": psdistance,
        "photo": photo,
        "ordernumber": orderNo,
        "latitude": latitude,
        "longitude": longitude,
        "taluka": taluka,
        "dangerzone": dangerzone,
      };
}
