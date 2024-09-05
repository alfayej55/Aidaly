// // To parse this JSON data, do
// //
// //     final productDetailsModel = productDetailsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));
//
// String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());
//
// class ProductDetailsModel {
//   String? status;
//   int? statusCode;
//   String? message;
//   Data? data;
//   Pagination? pagination;
//
//   ProductDetailsModel({
//     this.status,
//     this.statusCode,
//     this.message,
//     this.data,
//     this.pagination,
//   });
//
//   factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
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
//   Attributes? attributes;
//
//   Data({
//     this.attributes,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "attributes": attributes?.toJson(),
//   };
// }
//
// class Attributes {
//   Product? product;
//
//   Attributes({
//     this.product,
//   });
//
//   factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
//     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product": product?.toJson(),
//   };
// }
//
// class Product {
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
//   bool? wishlist;
//   bool? isNewArrivel;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   Product({
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
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
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
// class UserId {
//   String? id;
//   String? name;
//   String? email;
//   String? dateOfBirth;
//   String? phone;
//   String? address;
//   String? city;
//   String? rating;
//   String? state;
//   bool? privacyPolicyAccepted;
//   bool? isAdmin;
//   bool? isVerified;
//   bool? isDeleted;
//   bool? isBlocked;
//   bool? isLoggedIn;
//   Image? image;
//   String? role;
//   dynamic oneTimeCode;
//   int? v;
//   CurrentLocation? currentLocation;
//
//   UserId({
//     this.id,
//     this.name,
//     this.email,
//     this.dateOfBirth,
//     this.phone,
//     this.address,
//     this.city,
//     this.rating,
//     this.state,
//     this.privacyPolicyAccepted,
//     this.isAdmin,
//     this.isVerified,
//     this.isDeleted,
//     this.isBlocked,
//     this.isLoggedIn,
//     this.image,
//     this.role,
//     this.oneTimeCode,
//     this.v,
//     this.currentLocation,
//   });
//
//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//     id: json["_id"],
//     name: json["name"],
//     email: json["email"],
//     dateOfBirth: json["dateOfBirth"],
//     phone: json["phone"],
//     address: json["address"],
//     city: json["city"],
//     rating: json["rating"],
//     state: json["state"],
//     privacyPolicyAccepted: json["privacyPolicyAccepted"],
//     isAdmin: json["isAdmin"],
//     isVerified: json["isVerified"],
//     isDeleted: json["isDeleted"],
//     isBlocked: json["isBlocked"],
//     isLoggedIn: json["isLoggedIn"],
//     image: json["image"] == null ? null : Image.fromJson(json["image"]),
//     role: json["role"],
//     oneTimeCode: json["oneTimeCode"],
//     v: json["__v"],
//     currentLocation: json["currentLocation"] == null ? null : CurrentLocation.fromJson(json["currentLocation"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "email": email,
//     "dateOfBirth": dateOfBirth,
//     "phone": phone,
//     "address": address,
//     "city": city,
//     "rating": rating,
//     "state": state,
//     "privacyPolicyAccepted": privacyPolicyAccepted,
//     "isAdmin": isAdmin,
//     "isVerified": isVerified,
//     "isDeleted": isDeleted,
//     "isBlocked": isBlocked,
//     "isLoggedIn": isLoggedIn,
//     "image": image?.toJson(),
//     "role": role,
//     "oneTimeCode": oneTimeCode,
//     "__v": v,
//     "currentLocation": currentLocation?.toJson(),
//   };
// }
//
// class CurrentLocation {
//   String? userId;
//   double? latitude;
//   double? longitude;
//   String? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   CurrentLocation({
//     this.userId,
//     this.latitude,
//     this.longitude,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
//     userId: json["userId"],
//     latitude: json["latitude"]?.toDouble(),
//     longitude: json["longitude"]?.toDouble(),
//     id: json["_id"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "latitude": latitude,
//     "longitude": longitude,
//     "_id": id,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
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
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;
  Pagination? pagination;

  ProductDetailsModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
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
  Attributes? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  Product? product;
  BoutiqueLocation? boutiqueLocation;

  Attributes({
    this.product,
    this.boutiqueLocation,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    boutiqueLocation: json["boutiqueLocation"] == null ? null : BoutiqueLocation.fromJson(json["boutiqueLocation"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "boutiqueLocation": boutiqueLocation?.toJson(),
  };
}

class BoutiqueLocation {
  String? id;
  UserId? userId;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BoutiqueLocation({
    this.id,
    this.userId,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BoutiqueLocation.fromJson(Map<String, dynamic> json) => BoutiqueLocation(
    id: json["_id"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "latitude": latitude,
    "longitude": longitude,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserId {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? city;
  String? rate;
  String? rating;
  String? description;
  String? state;
  String? status;
  bool? privacyPolicyAccepted;
  bool? isAdmin;
  bool? isVerified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isLoggedIn;
  Image? image;
  String? role;
  dynamic oneTimeCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  CurrentLocation? currentLocation;

  UserId({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.city,
    this.rate,
    this.rating,
    this.description,
    this.state,
    this.status,
    this.privacyPolicyAccepted,
    this.isAdmin,
    this.isVerified,
    this.isDeleted,
    this.isBlocked,
    this.isLoggedIn,
    this.image,
    this.role,
    this.oneTimeCode,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.currentLocation,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    address: json["address"],
    city: json["city"],
    rate: json["rate"],
    rating: json["rating"],
    description: json["description"],
    state: json["state"],
    status: json["status"],
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isAdmin: json["isAdmin"],
    isVerified: json["isVerified"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    isLoggedIn: json["isLoggedIn"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    currentLocation: json["currentLocation"] == null ? null : CurrentLocation.fromJson(json["currentLocation"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "address": address,
    "city": city,
    "rate": rate,
    "rating": rating,
    "description": description,
    "state": state,
    "status": status,
    "privacyPolicyAccepted": privacyPolicyAccepted,
    "isAdmin": isAdmin,
    "isVerified": isVerified,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "isLoggedIn": isLoggedIn,
    "image": image?.toJson(),
    "role": role,
    "oneTimeCode": oneTimeCode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "currentLocation": currentLocation?.toJson(),
  };
}

class CurrentLocation {
  String? userId;
  double? latitude;
  double? longitude;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CurrentLocation({
    this.userId,
    this.latitude,
    this.longitude,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
    userId: json["userId"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "latitude": latitude,
    "longitude": longitude,
    "_id": id,
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

class Product {
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
  bool? wishlist;
  bool? isAproved;
  bool? isNewArrivel;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Product({
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
    this.wishlist,
    this.isAproved,
    this.isNewArrivel,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
  Pagination();
  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
