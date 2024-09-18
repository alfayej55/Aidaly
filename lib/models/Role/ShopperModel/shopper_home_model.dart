// //
// // class ShopperHomeModel {
// //   String? id;
// //   UserId? userId;
// //   String? name;
// //   String? price;
// //   String? slug;
// //   String? category;
// //   List<Image>? images;
// //   Image? firstImage;
// //   String? inventoryQuantity;
// //   List<String>? color;
// //
// //   String? rating;
// //   String? reviews;
// //   bool wishlist;
// //   bool? isNewArrivel;
// //   DateTime? createdAt;
// //   DateTime? updatedAt;
// //   int? v;
// //
// //   ShopperHomeModel({
// //     this.id,
// //     this.userId,
// //     this.name,
// //     this.price,
// //     this.slug,
// //     this.category,
// //     this.images,
// //     this.firstImage,
// //     this.inventoryQuantity,
// //     this.color,
// //
// //     this.rating,
// //     this.reviews,
// //     this.wishlist=false,
// //     this.isNewArrivel,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.v,
// //   });
// //
// //   factory ShopperHomeModel.fromJson(Map<String, dynamic> json) => ShopperHomeModel(
// //     id: json["_id"],
// //     userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
// //     name: json["name"],
// //     price: json["price"],
// //     slug: json["slug"],
// //     category: json["category"],
// //     images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
// //     firstImage: json["firstImage"] == null ? null : Image.fromJson(json["firstImage"]),
// //     inventoryQuantity: json["inventoryQuantity"],
// //     color: json["color"] == null ? [] : List<String>.from(json["color"]!.map((x) => x)),
// //     rating: json["rating"],
// //     reviews: json["reviews"],
// //     wishlist: json["wishlist"],
// //     isNewArrivel: json["isNewArrivel"],
// //     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
// //     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
// //     v: json["__v"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "_id": id,
// //     "userId": userId?.toJson(),
// //     "name": name,
// //     "price": price,
// //     "slug": slug,
// //     "category": category,
// //     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
// //     "firstImage": firstImage?.toJson(),
// //     "inventoryQuantity": inventoryQuantity,
// //     "color": color == null ? [] : List<dynamic>.from(color!.map((x) => x)),
// //     "rating": rating,
// //     "reviews": reviews,
// //     "wishlist": wishlist,
// //     "isNewArrivel": isNewArrivel,
// //     "createdAt": createdAt?.toIso8601String(),
// //     "updatedAt": updatedAt?.toIso8601String(),
// //     "__v": v,
// //   };
// // }
// //
// // class Image {
// //   String? publicFileUrl;
// //   String? path;
// //
// //   Image({
// //     this.publicFileUrl,
// //     this.path,
// //   });
// //
// //   factory Image.fromJson(Map<String, dynamic> json) => Image(
// //     publicFileUrl: json["publicFileUrl"],
// //     path: json["path"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "publicFileUrl": publicFileUrl,
// //     "path": path,
// //   };
// // }
// //
// //
// // class UserId {
// //   String? id;
// //   String? name;
// //   String? email;
// //   String? address;
// //   String? city;
// //   String? rate;
// //   String? rating;
// //   String? description;
// //   String? state;
// //   String? status;
// //   bool? privacyPolicyAccepted;
// //   bool? isAdmin;
// //   bool? isVerified;
// //   bool? isDeleted;
// //   bool? isBlocked;
// //   bool? isLoggedIn;
// //   Image? image;
// //   String? role;
// //   String? oneTimeCode;
// //   int? v;
// //   CurrentLocation? currentLocation;
// //   String? phone;
// //
// //   UserId({
// //     this.id,
// //     this.name,
// //     this.email,
// //     this.address,
// //     this.city,
// //     this.rate,
// //     this.rating,
// //     this.description,
// //     this.state,
// //     this.status,
// //     this.privacyPolicyAccepted,
// //     this.isAdmin,
// //     this.isVerified,
// //     this.isDeleted,
// //     this.isBlocked,
// //     this.isLoggedIn,
// //     this.image,
// //     this.role,
// //     this.oneTimeCode,
// //     this.v,
// //     this.currentLocation,
// //     this.phone,
// //   });
// //
// //   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
// //     id: json["_id"]!,
// //     name: json["name"]!,
// //     email: json["email"]!,
// //     address: json["address"]!,
// //     city: json["city"]!,
// //     rate: json["rate"],
// //     rating: json["rating"],
// //     description: json["description"]!,
// //     state: json["state"]!,
// //     status:json["status"]!,
// //     privacyPolicyAccepted: json["privacyPolicyAccepted"],
// //     isAdmin: json["isAdmin"],
// //     isVerified: json["isVerified"],
// //     isDeleted: json["isDeleted"],
// //     isBlocked: json["isBlocked"],
// //     isLoggedIn: json["isLoggedIn"],
// //     image: json["image"] == null ? null : Image.fromJson(json["image"]),
// //     role: json["role"]!,
// //     oneTimeCode: json["oneTimeCode"],
// //     v: json["__v"],
// //     currentLocation: json["currentLocation"] == null ? null : CurrentLocation.fromJson(json["currentLocation"]),
// //     phone: json["phone"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "_id": id,
// //     "name": name,
// //     "email": email,
// //     "address": address,
// //     "city": city,
// //     "rate": rate,
// //     "rating": rating,
// //     "description": description,
// //     "state": state,
// //     "status": status,
// //     "privacyPolicyAccepted": privacyPolicyAccepted,
// //     "isAdmin": isAdmin,
// //     "isVerified": isVerified,
// //     "isDeleted": isDeleted,
// //     "isBlocked": isBlocked,
// //     "isLoggedIn": isLoggedIn,
// //     "image": image?.toJson(),
// //     "role": role,
// //     "oneTimeCode": oneTimeCode,
// //     "__v": v,
// //     "currentLocation": currentLocation?.toJson(),
// //     "phone": phone,
// //   };
// // }
// //
// //
// //
// // class CurrentLocation {
// //   String? userId;
// //   double? latitude;
// //   double? longitude;
// //   String? id;
// //   DateTime? createdAt;
// //   DateTime? updatedAt;
// //   int? v;
// //
// //   CurrentLocation({
// //     this.userId,
// //     this.latitude,
// //     this.longitude,
// //     this.id,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.v,
// //   });
// //
// //   factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
// //     userId: json["userId"]!,
// //     latitude: json["latitude"]?.toDouble(),
// //     longitude: json["longitude"]?.toDouble(),
// //     id: json["_id"]!,
// //     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
// //     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
// //     v: json["__v"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "userId": userId,
// //     "latitude": latitude,
// //     "longitude": longitude,
// //     "_id":id,
// //     "createdAt": createdAt?.toIso8601String(),
// //     "updatedAt": updatedAt?.toIso8601String(),
// //     "__v": v,
// //   };
// // }
// //
// //
// //
// // class Pagination {
// //   Attributes? attributes;
// //
// //   Pagination({
// //     this.attributes,
// //   });
// //
// //   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
// //     attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "attributes": attributes?.toJson(),
// //   };
// // }
// //
// // class Attributes {
// //   int? currentPage;
// //   int? totalPages;
// //   dynamic nextPage;
// //   dynamic previousPage;
// //   int? totalItems;
// //
// //   Attributes({
// //     this.currentPage,
// //     this.totalPages,
// //     this.nextPage,
// //     this.previousPage,
// //     this.totalItems,
// //   });
// //
// //   factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
// //     currentPage: json["currentPage"],
// //     totalPages: json["totalPages"],
// //     nextPage: json["nextPage"],
// //     previousPage: json["previousPage"],
// //     totalItems: json["totalItems"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "currentPage": currentPage,
// //     "totalPages": totalPages,
// //     "nextPage": nextPage,
// //     "previousPage": previousPage,
// //     "totalItems": totalItems,
// //   };
// // }
// //
// //
// // To parse this JSON data, do
// //
// //     final shopperHomeModel = shopperHomeModelFromJson(jsonString);
//
// import 'dart:convert';
//
// class ShopperHomeModel {
//   String? id;
//   UserId? userId;
//   String? name;
//   String? price;
//   String? slug;
//   String? category;
//   List<Image>? images;
//   Image? firstImage;
//   List<String>? color;
//   List<Variant>? variants;
//   String? rating;
//   String? reviews;
//   bool wishlist;
//   bool? isAproved;
//   bool? isNewArrivel;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   ShopperHomeModel({
//     this.id,
//     this.userId,
//     this.name,
//     this.price,
//     this.slug,
//     this.category,
//     this.images,
//     this.firstImage,
//     this.color,
//     this.variants,
//     this.rating,
//     this.reviews,
//     this.wishlist=false,
//     this.isAproved,
//     this.isNewArrivel,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory ShopperHomeModel.fromJson(Map<String, dynamic> json) => ShopperHomeModel(
//     id: json["_id"],
//     userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
//     name: json["name"],
//     price: json["price"],
//     slug: json["slug"],
//     category: json["category"],
//     images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     firstImage: json["firstImage"] == null ? null : Image.fromJson(json["firstImage"]),
//     color: json["color"] == null ? [] : List<String>.from(json["color"]!.map((x) => x)),
//     variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
//     rating: json["rating"],
//     reviews: json["reviews"],
//     wishlist: json["wishlist"],
//     isAproved: json["isAproved"],
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
//     "color": color == null ? [] : List<dynamic>.from(color!.map((x) => x)),
//     "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
//     "rating": rating,
//     "reviews": reviews,
//     "wishlist": wishlist,
//     "isAproved": isAproved,
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
//   String? password;
//   String? phone;
//   String? address;
//   String? city;
//   String? rate;
//   String? rating;
//   String? description;
//   String? state;
//   String? status;
//   bool? privacyPolicyAccepted;
//   bool? isAdmin;
//   bool? isVerified;
//   bool? isDeleted;
//   bool? isBlocked;
//   bool? isLoggedIn;
//   Image? image;
//   String? role;
//   dynamic oneTimeCode;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   UserId({
//     this.id,
//     this.name,
//     this.email,
//     this.password,
//     this.phone,
//     this.address,
//     this.city,
//     this.rate,
//     this.rating,
//     this.description,
//     this.state,
//     this.status,
//     this.privacyPolicyAccepted,
//     this.isAdmin,
//     this.isVerified,
//     this.isDeleted,
//     this.isBlocked,
//     this.isLoggedIn,
//     this.image,
//     this.role,
//     this.oneTimeCode,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//     id: json["_id"],
//     name: json["name"],
//     email: json["email"],
//     password: json["password"],
//     phone: json["phone"],
//     address: json["address"],
//     city: json["city"],
//     rate: json["rate"],
//     rating: json["rating"],
//     description: json["description"],
//     state: json["state"],
//     status: json["status"],
//     privacyPolicyAccepted: json["privacyPolicyAccepted"],
//     isAdmin: json["isAdmin"],
//     isVerified: json["isVerified"],
//     isDeleted: json["isDeleted"],
//     isBlocked: json["isBlocked"],
//     isLoggedIn: json["isLoggedIn"],
//     image: json["image"] == null ? null : Image.fromJson(json["image"]),
//     role: json["role"],
//     oneTimeCode: json["oneTimeCode"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "email": email,
//     "password": password,
//     "phone": phone,
//     "address": address,
//     "city": city,
//     "rate": rate,
//     "rating": rating,
//     "description": description,
//     "state": state,
//     "status": status,
//     "privacyPolicyAccepted": privacyPolicyAccepted,
//     "isAdmin": isAdmin,
//     "isVerified": isVerified,
//     "isDeleted": isDeleted,
//     "isBlocked": isBlocked,
//     "isLoggedIn": isLoggedIn,
//     "image": image?.toJson(),
//     "role": role,
//     "oneTimeCode": oneTimeCode,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class Variant {
//   String? size;
//   String? color;
//   int? inventoryQuantity;
//   int? price;
//   String? id;
//
//   Variant({
//     this.size,
//     this.color,
//     this.inventoryQuantity,
//     this.price,
//     this.id,
//   });
//
//   factory Variant.fromJson(Map<String, dynamic> json) => Variant(
//     size: json["size"],
//     color: json["color"],
//     inventoryQuantity: json["inventoryQuantity"],
//     price: json["price"],
//     id: json["_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "size": size,
//     "color": color,
//     "inventoryQuantity": inventoryQuantity,
//     "price": price,
//     "_id": id,
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
//   dynamic previousPage;
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

// To parse this JSON data, do
//
//     final shopperHomeModel = shopperHomeModelFromJson(jsonString);


class ShopperHomeModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? fcmToken;
  int? boutiquePersentage;
  String? phone;
  String? address;
  String? city;
  String? rate;
  String? rating;
  int? earnedMoney;
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
  Image? promotionImage;

  ShopperHomeModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.fcmToken,
    this.boutiquePersentage,
    this.phone,
    this.address,
    this.city,
    this.rate,
    this.rating,
    this.earnedMoney,
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
    this.promotionImage,
  });

  factory ShopperHomeModel.fromJson(Map<String, dynamic> json) => ShopperHomeModel(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    fcmToken: json["fcmToken"],
    boutiquePersentage: json["boutiquePersentage"],
    phone: json["phone"],
    address: json["address"],
    city: json["city"],
    rate: json["rate"],
    rating: json["rating"],
    earnedMoney: json["earnedMoney"],
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
    promotionImage: json["promotionImage"] == null ? null : Image.fromJson(json["promotionImage"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "fcmToken": fcmToken,
    "boutiquePersentage": boutiquePersentage,
    "phone": phone,
    "address": address,
    "city": city,
    "rate": rate,
    "rating": rating,
    "earnedMoney": earnedMoney,
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
    "promotionImage": promotionImage?.toJson(),
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
