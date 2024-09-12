
class BankInfoModel {
  String? id;
  String? userId;
  String? bankName;
  String? bnakAccountNumber;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BankInfoModel({
    this.id,
    this.userId,
    this.bankName,
    this.bnakAccountNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BankInfoModel.fromJson(Map<String, dynamic> json) => BankInfoModel(
    id: json["_id"],
    userId: json["userId"],
    bankName: json["bankName"],
    bnakAccountNumber: json["bnakAccountNumber"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "bankName": bankName,
    "bnakAccountNumber": bnakAccountNumber,
    "status": status,
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
