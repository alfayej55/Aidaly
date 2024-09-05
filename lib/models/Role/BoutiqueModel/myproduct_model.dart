// // To parse this JSON data, do
// //
// //     final boutiqueMyProductModel = boutiqueMyProductModelFromJson(jsonString);
//
// import 'dart:convert';
//
// BoutiqueMyProductModel boutiqueMyProductModelFromJson(String str) => BoutiqueMyProductModel.fromJson(json.decode(str));
//
// String boutiqueMyProductModelToJson(BoutiqueMyProductModel data) => json.encode(data.toJson());
//
// class BoutiqueMyProductModel {
//   String? status;
//   int? statusCode;
//   String? message;
//   Data? data;
//   Pagination? pagination;
//
//   BoutiqueMyProductModel({
//     this.status,
//     this.statusCode,
//     this.message,
//     this.data,
//     this.pagination,
//   });
//
//   factory BoutiqueMyProductModel.fromJson(Map<String, dynamic> json) => BoutiqueMyProductModel(
//     status: json["status"],
//     statusCode: json["statusCode"],
//     message: json["message"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "statusCode": statusCode,
//     "message": message,
//     "data": data?.toJson(),
//     "pagination": pagination?.toJson(),
//   };
// }
//
// class Data {
//   List<Attribute>? attributes;
//
//   Data({
//     this.attributes,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
//   };
// }
//
// class Attribute {
//   String? id;
//   String? userId;
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
//   bool? wishlist;
//   bool? isNewArrivel;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   Attribute({
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
//     this.wishlist,
//     this.isNewArrivel,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
//     id: json["_id"],
//     userId: json["userId"],
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
//     "userId": userId,
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
// class Pagination {
//   Pagination();
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//   );
//
//   Map<String, dynamic> toJson() => {
//   };
// }


// To parse this JSON data, do
//
//     final boutiqueMyProductModel = boutiqueMyProductModelFromJson(jsonString);



// To parse this JSON data, do
//
//     final boutiqueMyProductModel = boutiqueMyProductModelFromJson(jsonString);

import 'dart:convert';

BoutiqueMyProductModel boutiqueMyProductModelFromJson(String str) => BoutiqueMyProductModel.fromJson(json.decode(str));

String boutiqueMyProductModelToJson(BoutiqueMyProductModel data) => json.encode(data.toJson());

class BoutiqueMyProductModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;
  Pagination? pagination;

  BoutiqueMyProductModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory BoutiqueMyProductModel.fromJson(Map<String, dynamic> json) => BoutiqueMyProductModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
    "pagination": pagination?.toJson(),
  };
}

class Data {
  List<Attribute>? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class Attribute {
  String? id;
  String? userId;
  String? name;
  String? slug;
  String? category;
  List<Image>? images;
  Image? firstImage;
  List<String>? color;
  List<Variant>? variants;
  String? rating;
  String? reviews;
  bool? wishlist;
  bool? isAproved;
  bool? isNewArrivel;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attribute({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.category,
    this.images,
    this.firstImage,
    this.color,
    this.variants,
    this.rating,
    this.reviews,
    this.wishlist,
    this.isAproved,
    this.isNewArrivel,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
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
    "userId": userId,
    "name": name,
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

class Variant {
  String? size;
  int? inventoryQuantity;
  int? price;
  String? id;

  Variant({
    this.size,
    this.inventoryQuantity,
    this.price,
    this.id,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    size: json["size"],
    inventoryQuantity: json["inventoryQuantity"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "inventoryQuantity": inventoryQuantity,
    "price": price,
    "_id": id,
  };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}


