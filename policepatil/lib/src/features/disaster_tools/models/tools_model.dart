class ToolsResponse {
  ToolsResponse({
    this.message,
    this.data,
  });

  String? message;
  List<ToolsData>? data;

  factory ToolsResponse.fromJson(Map<String, dynamic> json) => ToolsResponse(
        message: json["message"],
        data: List<ToolsData>.from(
            json["data"].map((x) => ToolsData.fromJson(x))),
      );
}

class ToolsData {
  ToolsData({
    this.id,
    this.name,
    this.quantity,
    this.type,
    this.ppid,
    this.psid,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? quantity;
  String? type;
  int? ppid;
  int? psid;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ToolsData.fromJson(Map<String, dynamic> json) => ToolsData(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        type: json["type"],
        ppid: json["ppid"],
        psid: json["psid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity.toString(),
        "ppid": ppid,
        "psid": psid
      };
}
