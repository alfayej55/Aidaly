// To parse this JSON data, do
//
//     final shopCategoryModel = shopCategoryModelFromJson(jsonString);

import 'dart:convert';

ShopCategoryModel shopCategoryModelFromJson(String str) => ShopCategoryModel.fromJson(json.decode(str));

String shopCategoryModelToJson(ShopCategoryModel data) => json.encode(data.toJson());

class ShopCategoryModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;

  ShopCategoryModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) => ShopCategoryModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
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
  List<AllProduct>? allProducts;

  Attributes({
    this.allProducts,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    allProducts: json["allProducts"] == null ? [] : List<AllProduct>.from(json["allProducts"]!.map((x) => AllProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "allProducts": allProducts == null ? [] : List<dynamic>.from(allProducts!.map((x) => x.toJson())),
  };
}

class AllProduct {
  String? id;
  String? name;
  String? description;
  CategoryImage? categoryImage;
  int? v;

  AllProduct({
    this.id,
    this.name,
    this.description,
    this.categoryImage,
    this.v,
  });

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    categoryImage: json["categoryImage"] == null ? null : CategoryImage.fromJson(json["categoryImage"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "categoryImage": categoryImage?.toJson(),
    "__v": v,
  };
}

class CategoryImage {
  String? publicFileUrl;
  String? path;

  CategoryImage({
    this.publicFileUrl,
    this.path,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) => CategoryImage(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}
