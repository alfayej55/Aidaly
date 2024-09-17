

import 'package:aidaly/models/Role/ShopperModel/shop_subcategori_model.dart';

class WishListFolderModel {
  WishlistId? wishlistId;
  String? id;
  ShopperProductModel?collection;

  WishListFolderModel({
    this.wishlistId,
    this.collection,
    this.id,
  });

  factory WishListFolderModel.fromJson(Map<String, dynamic> json) => WishListFolderModel(
    wishlistId: json["wishlistId"] == null ? null : WishlistId.fromJson(json["wishlistId"]),
    collection: json["collection"] == null ? null : ShopperProductModel.fromJson(json["collection"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "wishlistId": wishlistId?.toJson(),
    "collection": collection?.toJson(),
    "_id": id,
  };
}

class WishlistId {
  String? id;
  String? userId;
  ShopperProductModel?productId;
  int? v;

  WishlistId({
    this.id,
    this.userId,
    this.productId,
    this.v,
  });

  factory WishlistId.fromJson(Map<String, dynamic> json) => WishlistId(
    id: json["_id"],
    userId: json["userId"],
    productId: json["productId"] == null ? null : ShopperProductModel.fromJson(json["productId"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "productId": productId?.toJson(),
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
  String? email;
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
  String? oneTimeCode;
  int? v;

  String? phone;

  UserId({
    this.id,
    this.name,
    this.email,
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
    this.v,

    this.phone,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
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
    v: json["__v"],

    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
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
    "__v": v,

    "phone": phone,
  };
}




