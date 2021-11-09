class PsList {
  PsList({
    this.message,
    this.data,
  });

  String? message;
  List<PoliceStation>? data;

  factory PsList.fromJson(Map<String, dynamic> json) => PsList(
        message: json["message"],
        data: List<PoliceStation>.from(
            json["data"].map((x) => PoliceStation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PoliceStation {
  PoliceStation({
    this.id,
    this.psname,
    this.address,
  });

  int? id;
  String? psname;
  String? address;

  factory PoliceStation.fromJson(Map<String, dynamic> json) => PoliceStation(
        id: json["id"],
        psname: json["psname"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "psname": psname,
        "address": address,
      };
}
