

class ShopperProductModel {
  String? id;
  UserId? userId;
  String? name;
  String? price;
  String? slug;
  String? category;
  List<Image>? images;
  Image? firstImage;
  List<String>? color;
  List<Variant>? variants;
  String? rating;
  String? reviews;
  bool wishlist;
  bool? isAproved;
  bool? isNewArrivel;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ShopperProductModel({
    this.id,
    this.userId,
    this.name,
    this.price,
    this.slug,
    this.category,
    this.images,
    this.firstImage,
    this.color,
    this.variants,
    this.rating,
    this.reviews,
    this.wishlist=false,
    this.isAproved,
    this.isNewArrivel,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ShopperProductModel.fromJson(Map<String, dynamic> json) => ShopperProductModel(
    id: json["_id"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    name: json["name"],
    price: json["price"],
    slug: json["slug"],
    category: json["category"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    firstImage: json["firstImage"] == null ? null : Image.fromJson(json["firstImage"]),
    color: json["color"] == null ? [] : List<String>.from(json["color"]!.map((x) => x)),
    variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
    rating: json["rating"],
    reviews: json["reviews"],
    wishlist: json["wishlist"],
    isAproved: json["isAproved"],
    isNewArrivel: json["isNewArrivel"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "name": name,
    "price": price,
    "slug": slug,
    "category": category,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "firstImage": firstImage?.toJson(),
    "color": color == null ? [] : List<dynamic>.from(color!.map((x) => x)),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
    "rating": rating,
    "reviews": reviews,
    "wishlist": wishlist,
    "isAproved": isAproved,
    "isNewArrivel": isNewArrivel,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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
  bool? isBlocked;
  Image? image;

  UserId({
    this.id,
    this.name,
    this.isBlocked,
    this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    isBlocked: json["isBlocked"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isBlocked": isBlocked,
    "image": image?.toJson(),
  };
}

class Variant {
  String? size;
  String? color;
  int? inventoryQuantity;
  int? price;
  String? id;

  Variant({
    this.size,
    this.color,
    this.inventoryQuantity,
    this.price,
    this.id,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    size: json["size"],
    color: json["color"],
    inventoryQuantity: json["inventoryQuantity"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "color": color,
    "inventoryQuantity": inventoryQuantity,
    "price": price,
    "_id": id,
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


// class ShopperProductModel {
//   String? id;
//   UserId? userId;
//   String? name;
//   String? price;
//   String? slug;
//   String? category;
//   List<Image>? images;
//   Image? firstImage;
//   String? inventoryQuantity;
//   List<String>? color;
//   List<String>? size;
//   String? rating;
//   String? reviews;
//   bool wishlist;
//   bool? isNewArrivel;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   ShopperProductModel({
//     this.id,
//     this.userId,
//     this.name,
//     this.price,
//     this.slug,
//     this.category,
//     this.images,
//     this.firstImage,
//     this.inventoryQuantity,
//     this.color,
//     this.size,
//     this.rating,
//     this.reviews,
//     this.wishlist=false,
//     this.isNewArrivel,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory ShopperProductModel.fromJson(Map<String, dynamic> json) => ShopperProductModel(
//     id: json["_id"],
//     userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
//     name: json["name"],
//     price: json["price"],
//     slug: json["slug"],
//     category: json["category"],
//     images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     firstImage: json["firstImage"] == null ? null : Image.fromJson(json["firstImage"]),
//     inventoryQuantity: json["inventoryQuantity"],
//     color: json["color"] == null ? [] : List<String>.from(json["color"]!.map((x) => x)),
//     size: json["size"] == null ? [] : List<String>.from(json["size"]!.map((x) => x)),
//     rating: json["rating"],
//     reviews: json["reviews"],
//     wishlist: json["wishlist"],
//     isNewArrivel: json["isNewArrivel"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "userId": userId?.toJson(),
//     "name": name,
//     "price": price,
//     "slug": slug,
//     "category": category,
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "firstImage": firstImage?.toJson(),
//     "inventoryQuantity": inventoryQuantity,
//     "color": color == null ? [] : List<dynamic>.from(color!.map((x) => x)),
//     "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x)),
//     "rating": rating,
//     "reviews": reviews,
//     "wishlist": wishlist,
//     "isNewArrivel": isNewArrivel,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class Image {
//   String? publicFileUrl;
//   String? path;
//
//   Image({
//     this.publicFileUrl,
//     this.path,
//   });
//
//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//     publicFileUrl: json["publicFileUrl"],
//     path: json["path"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "publicFileUrl": publicFileUrl,
//     "path": path,
//   };
// }
//
// class  UserId {
//   String? id;
//   String? name;
//   Image? image;
//
//   UserId({
//     this.id,
//     this.name,
//     this.image,
//   });
//
//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//     id: json["_id"],
//     name: json["name"],
//     image: json["image"] == null ? null : Image.fromJson(json["image"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "image": image?.toJson(),
//   };
// }
//
// class Pagination {
//   Attributes? attributes;
//
//   Pagination({
//     this.attributes,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//     attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "attributes": attributes?.toJson(),
//   };
// }
//
// class Attributes {
//   int? currentPage;
//   int? totalPages;
//   dynamic nextPage;
//   int? previousPage;
//   int? totalItems;
//
//   Attributes({
//     this.currentPage,
//     this.totalPages,
//     this.nextPage,
//     this.previousPage,
//     this.totalItems,
//   });
//
//   factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
//     currentPage: json["currentPage"],
//     totalPages: json["totalPages"],
//     nextPage: json["nextPage"],
//     previousPage: json["previousPage"],
//     totalItems: json["totalItems"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currentPage": currentPage,
//     "totalPages": totalPages,
//     "nextPage": nextPage,
//     "previousPage": previousPage,
//     "totalItems": totalItems,
//   };
// }
