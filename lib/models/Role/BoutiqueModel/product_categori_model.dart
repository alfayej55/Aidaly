
class AllCatagoryModel {
  String? id;
  String? name;
  String? description;
  String? sizeType;
  int? v;

  AllCatagoryModel({
    this.id,
    this.name,
    this.sizeType,
    this.description,
    this.v,
  });

  factory AllCatagoryModel.fromJson(Map<String, dynamic> json) => AllCatagoryModel(
    id: json["_id"],
    name: json["name"],
    sizeType: json["sizeType"],
    description: json["description"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "sizeType": sizeType,
    "description": description,
    "__v": v,
  };
}
