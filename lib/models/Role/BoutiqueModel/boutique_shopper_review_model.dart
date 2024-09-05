
class BoutiqueAllShopperReviewModel {
  String? id;
  UserId? userId;
  String? productId;
  String? height;
  String? weight;
  List<Image>? reviewImage;
  String? rating;
  String? reviews;
  dynamic commentCount;
  dynamic likeCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  BoutiqueAllShopperReviewModel({
    this.id,
    this.userId,
    this.productId,
    this.likeCount,
    this.commentCount,
    this.height,
    this.weight,
    this.reviewImage,
    this.rating,
    this.reviews,
    this.createdAt,
    this.updatedAt,
  });

  factory BoutiqueAllShopperReviewModel.fromJson(Map<String, dynamic> json) => BoutiqueAllShopperReviewModel(
    id: json["_id"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    productId: json["ProductId"],
    height: json["height"],
    weight: json["weight"],
    reviewImage: json["reviewImage"] == null ? [] : List<Image>.from(json["reviewImage"]!.map((x) => Image.fromJson(x))),
    rating: json["rating"],
    reviews: json["reviews"],
    likeCount: json["likeCount"],
    commentCount: json["commentCount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "ProductId": productId,
    "height": height,
    "weight": weight,
    "reviewImage": reviewImage == null ? [] : List<dynamic>.from(reviewImage!.map((x) => x.toJson())),
    "rating": rating,
    "reviews": reviews,
    "likeCount": likeCount,
    "commentCount":commentCount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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

class UserId {
  String? id;
  String? name;
  String? email;
  Image? image;

  UserId({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "image": image?.toJson(),
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
