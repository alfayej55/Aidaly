
class AllNotificationModel {
  String? id;
  String? receiverId;
  String? title;
  String? message;
  String? role;
  String? type;
  bool? viewStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AllNotificationModel({
    this.id,
    this.receiverId,
    this.title,
    this.message,
    this.role,
    this.type,
    this.viewStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AllNotificationModel.fromJson(Map<String, dynamic> json) => AllNotificationModel(
    id: json["_id"],
    receiverId: json["receiverId"],
    title: json["title"],
    message: json["message"],
    role: json["role"],
    type: json["type"],
    viewStatus: json["viewStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "receiverId": receiverId,
    "title": title,
    "message": message,
    "role": role,
    "type": type,
    "viewStatus": viewStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
