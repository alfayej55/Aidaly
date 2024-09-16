
class CommentReplayModel {
  String? id;
  String? reviewId;
  UserId? userId;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CommentReplayModel({
    this.id,
    this.reviewId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CommentReplayModel.fromJson(Map<String, dynamic> json) => CommentReplayModel(
    id: json["_id"],
    reviewId: json["reviewId"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    comment: json["comment"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reviewId": reviewId,
    "userId": userId?.toJson(),
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserId {
  String? id;
  String? name;
  Image? image;

  UserId({
    this.id,
    this.name,
    this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image?.toJson(),
  };
}

class Image {
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}

class Pagination {
  Attributes? attributes;

  Pagination({
    this.attributes,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  int? currentPage;
  int? totalPages;
  dynamic nextPage;
  dynamic previousPage;
  int? totalItems;

  Attributes({
    this.currentPage,
    this.totalPages,
    this.nextPage,
    this.previousPage,
    this.totalItems,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    nextPage: json["nextPage"],
    previousPage: json["previousPage"],
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "nextPage": nextPage,
    "previousPage": previousPage,
    "totalItems": totalItems,
  };
}
