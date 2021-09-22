import 'dart:convert';

CurrentUserData currentUserDataFromJson(String str) =>
    CurrentUserData.fromJson(json.decode(str));

String currentUserDataToJson(CurrentUserData data) =>
    json.encode(data.toJson());

class CurrentUserData {
  CurrentUserData({
    required this.data,
    required this.ad,
  });

  Data data;
  Ad ad;

  factory CurrentUserData.fromJson(Map<String, dynamic> json) =>
      CurrentUserData(
        data: Data.fromJson(json["data"]),
        ad: Ad.fromJson(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "ad": ad.toJson(),
      };
}

class Ad {
  Ad({
    required this.company,
    required this.url,
    required this.text,
  });

  String company;
  String url;
  String text;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        company: json["company"],
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "url": url,
        "text": text,
      };
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avtar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avtar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avtar: json["avtar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "avtar": avtar,
      };
}
