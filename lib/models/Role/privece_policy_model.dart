

class PrivecyPolicyModel {
  String? id;
  String? userId;
  String? privacypolicyDroperDriver;
  String? otherPolicyDroperDriver;
  int? v;

  PrivecyPolicyModel({
    this.id,
    this.userId,
    this.privacypolicyDroperDriver,
    this.otherPolicyDroperDriver,
    this.v,
  });

  factory PrivecyPolicyModel.fromJson(Map<String, dynamic> json) => PrivecyPolicyModel(
    id: json["_id"],
    userId: json["userId"],
    privacypolicyDroperDriver: json["privacypolicyDroperDriver"],
    otherPolicyDroperDriver: json["otherPolicyDroperDriver"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "privacypolicyDroperDriver": privacypolicyDroperDriver,
    "otherPolicyDroperDriver": otherPolicyDroperDriver,
    "__v": v,
  };
}


