class VillageList {
  VillageList({
    this.message,
    this.data,
  });

  String? message;
  List<Village>? data;

  factory VillageList.fromJson(Map<String, dynamic> json) => VillageList(
        message: json["message"],
        data: List<Village>.from(json["data"].map((x) => Village.fromJson(x))),
      );
}

class Village {
  Village({
    this.village,
    this.ppid,
  });

  String? village;
  int? ppid;

  factory Village.fromJson(Map<String, dynamic> json) => Village(
        village: json["village"],
        ppid: json["id"],
      );
}
