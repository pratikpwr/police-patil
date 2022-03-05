enum AppStatus { latest, fine, outdated }

class AppVersion {
  AppVersion({
    this.message,
    this.minVersion,
    this.latestVersion,
    this.note,
  });

  String? message;
  String? minVersion;
  String? latestVersion;
  String? note;

  factory AppVersion.fromJson(Map<String, dynamic> json) => AppVersion(
        message: json["message"],
        minVersion: json["minversion"],
        latestVersion: json["latestversion"],
        note: json["note"],
      );
}
