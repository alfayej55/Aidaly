

import 'package:aidaly/models/Role/ShopperModel/shop_subcategori_model.dart';

class WishListModel {
  String? id;
  String? userId;
  ShopperProductModel?productId;
  int? v;

  WishListModel({
    this.id,
    this.userId,
    this.productId,
    this.v,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
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
