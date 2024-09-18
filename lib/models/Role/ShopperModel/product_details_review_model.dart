
class ProductCommentModel {
  String? id;
  UserId? userId;
  String? productId;
  dynamic height;
  dynamic weight;
  List<ReviewImage>? reviewImage;
  String? rating;
  String? reviews;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  dynamic likeCount;
  dynamic commentCount;
  bool isLiked;

  ProductCommentModel({
    this.id,
    this.userId,
    this.productId,
    this.height,
    this.weight,
    this.reviewImage,
    this.rating,
    this.reviews,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.likeCount,
    this.commentCount,
    this.isLiked=false,
  });

  factory ProductCommentModel.fromJson(Map<String, dynamic> json) => ProductCommentModel(
    id: json["_id"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    productId: json["ProductId"],
    height: json["height"],
    weight: json["weight"],
    reviewImage: json["reviewImage"] == null ? [] : List<ReviewImage>.from(json["reviewImage"]!.map((x) => ReviewImage.fromJson(x))),
    rating: json["rating"],
    reviews: json["reviews"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    likeCount: json["likeCount"],
    commentCount: json["commentCount"],
    isLiked: json["isLiked"],
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "likeCount": likeCount,
    "commentCount": commentCount,
    "isLiked": isLiked,
  };
}

class ReviewImage {
  String? publicFileUrl;
  String? path;

  ReviewImage({
    this.publicFileUrl,
    this.path,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) => ReviewImage(
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
