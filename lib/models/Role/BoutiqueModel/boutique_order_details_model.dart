// To parse this JSON data, do
//
//     final boutiqueOrderDetailsModel = boutiqueOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

BoutiqueOrderDetailsModel boutiqueOrderDetailsModelFromJson(String str) => BoutiqueOrderDetailsModel.fromJson(json.decode(str));

String boutiqueOrderDetailsModelToJson(BoutiqueOrderDetailsModel data) => json.encode(data.toJson());

class BoutiqueOrderDetailsModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;
  Pagination? pagination;

  BoutiqueOrderDetailsModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory BoutiqueOrderDetailsModel.fromJson(Map<String, dynamic> json) => BoutiqueOrderDetailsModel(
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
  DetailsOfOrder? detailsOfOrder;
  dynamic boutique;

  Attributes({
    this.detailsOfOrder,
    this.boutique,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    detailsOfOrder: json["detailsOfOrder"] == null ? null : DetailsOfOrder.fromJson(json["detailsOfOrder"]),
    boutique: json["boutique"],
  );

  Map<String, dynamic> toJson() => {
    "detailsOfOrder": detailsOfOrder?.toJson(),
    "boutique": boutique,
  };
}

class DetailsOfOrder {
  PaymentMethod? paymentMethod;
  String? id;
  String? orderId;
  String? userId;
  String? boutiqueId;
  OrderItems? orderItems;
  String? totalAmount;
  String? serviceFee;
  String? shippingFee;
  String? tips;
  String? tax;
  String? status;
  String? deliveryAddress;
  dynamic assignedDriver;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DetailsOfOrder({
    this.paymentMethod,
    this.id,
    this.orderId,
    this.userId,
    this.boutiqueId,
    this.orderItems,
    this.totalAmount,
    this.serviceFee,
    this.shippingFee,
    this.tips,
    this.tax,
    this.status,
    this.deliveryAddress,
    this.assignedDriver,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DetailsOfOrder.fromJson(Map<String, dynamic> json) => DetailsOfOrder(
    paymentMethod: json["paymentMethod"] == null ? null : PaymentMethod.fromJson(json["paymentMethod"]),
    id: json["_id"],
    orderId: json["orderId"],
    userId: json["userId"],
    boutiqueId: json["boutiqueId"],
    orderItems: json["orderItems"] == null ? null : OrderItems.fromJson(json["orderItems"]),
    totalAmount: json["totalAmount"],
    serviceFee: json["serviceFee"],
    shippingFee: json["shippingFee"],
    tips: json["tips"],
    tax: json["tax"],
    status: json["status"],
    deliveryAddress: json["deliveryAddress"],
    assignedDriver: json["assignedDriver"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "paymentMethod": paymentMethod?.toJson(),
    "_id": id,
    "orderId": orderId,
    "userId": userId,
    "boutiqueId": boutiqueId,
    "orderItems": orderItems?.toJson(),
    "totalAmount": totalAmount,
    "serviceFee": serviceFee,
    "shippingFee": shippingFee,
    "tips": tips,
    "tax": tax,
    "status": status,
    "deliveryAddress": deliveryAddress,
    "assignedDriver": assignedDriver,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class OrderItems {
  String? id;
  List<OrederedProduct>? orederedProduct;

  OrderItems({
    this.id,
    this.orederedProduct,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
    id: json["_id"],
    orederedProduct: json["orederedProduct"] == null ? [] : List<OrederedProduct>.from(json["orederedProduct"]!.map((x) => OrederedProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orederedProduct": orederedProduct == null ? [] : List<dynamic>.from(orederedProduct!.map((x) => x.toJson())),
  };
}

class OrederedProduct {
  int? id;
  String? productId;
  String? productName;
  String? productColor;
  String? productSize;
  int? productPrice;
  int? quantity;
  String? image;

  OrederedProduct({
    this.id,
    this.productId,
    this.productName,
    this.productColor,
    this.productSize,
    this.productPrice,
    this.quantity,
    this.image,
  });

  factory OrederedProduct.fromJson(Map<String, dynamic> json) => OrederedProduct(
    id: json["id"],
    productId: json["productId"],
    productName: json["productName"],
    productColor: json["productColor"],
    productSize: json["productSize"],
    productPrice: json["productPrice"],
    quantity: json["quantity"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "productName": productName,
    "productColor": productColor,
    "productSize": productSize,
    "productPrice": productPrice,
    "quantity": quantity,
    "image": image,
  };
}

class PaymentMethod {
  String? transectionId;
  String? methodName;

  PaymentMethod({
    this.transectionId,
    this.methodName,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    transectionId: json["transectionId"],
    methodName: json["methodName"],
  );

  Map<String, dynamic> toJson() => {
    "transectionId": transectionId,
    "methodName": methodName,
  };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
