import 'dart:convert';
import 'package:aidaly/models/Role/ShopperModel/shop_subcategori_model.dart';

class BoutiqueDetailsModel {
  String? message;
  Data? data;
  Pagination? pagination;

  BoutiqueDetailsModel({
    this.message,
    this.data,
    this.pagination,
  });

  factory BoutiqueDetailsModel.fromJson(Map<String, dynamic> json) => BoutiqueDetailsModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );


}

class Data {
  DataAttributes? attributes;
  Data({
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attributes: json["attributes"] == null ? null : DataAttributes.fromJson(json["attributes"]),
  );

}

class DataAttributes {
  BoutiqueUser? boutiqueUser;
  List<ShopperProductModel>? products;

  DataAttributes({
    this.boutiqueUser,
    this.products,
  });

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
    boutiqueUser: json["boutiqueUser"] == null ? null : BoutiqueUser.fromJson(json["boutiqueUser"]),
    products: json["products"] == null ? [] : List<ShopperProductModel>.from(json["products"]!.map((x) => ShopperProductModel.fromJson(x))),
  );

}

class BoutiqueUser {
  String? name;
  Image? image;
  String? description;
  String? rating;

  BoutiqueUser({
    this.name,
    this.image,
    this.description,
    this.rating,
  });

  factory BoutiqueUser.fromJson(Map<String, dynamic> json) => BoutiqueUser(
    name: json["name"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    description: json["description"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image?.toJson(),
    "description": description,
    "rating": rating,
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
  PaginationAttributes? attributes;

  Pagination({
    this.attributes,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    attributes: json["attributes"] == null ? null : PaginationAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes?.toJson(),
  };
}

class PaginationAttributes {
  int? currentPage;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  int? totalItems;

  PaginationAttributes({
    this.currentPage,
    this.totalPages,
    this.nextPage,
    this.previousPage,
    this.totalItems,
  });

  factory PaginationAttributes.fromJson(Map<String, dynamic> json) => PaginationAttributes(
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
  };}
