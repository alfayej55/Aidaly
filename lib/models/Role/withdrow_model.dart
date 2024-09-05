

class WithdeowModel {
  String? id;
  String? userId;
  String? bankName;
  String? bnakAccountNumber;
  int? withdrowAmount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  WithdeowModel({
    this.id,
    this.userId,
    this.bankName,
    this.bnakAccountNumber,
    this.withdrowAmount,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.v,
  });

  factory WithdeowModel.fromJson(Map<String, dynamic> json) => WithdeowModel(
    id: json["_id"],
    userId: json["userId"],
    bankName: json["bankName"],
    bnakAccountNumber: json["bnakAccountNumber"],
    withdrowAmount: json["withdrowAmount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    status: json["status"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "bankName":bankName,
    "bnakAccountNumber": bnakAccountNumber,
    "withdrowAmount": withdrowAmount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "status": status,
    "__v": v,
  };
}



