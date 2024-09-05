

class DriverOrderModel {
  PaymentMethod? paymentMethod;
  String? id;
  String? orderId;
  String? userId;
  BoutiqueId? boutiqueId;
  OrderItems? orderItems;
  String? totalAmount;
  String? serviceFee;
  String? shippingFee;
  String? tips;
  String? tax;
  String? subTotal;
  String? status;
  String? deliveryAddress;
  String? assignedDriver;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DriverOrderModel({
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
    this.subTotal,
    this.status,
    this.deliveryAddress,
    this.assignedDriver,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DriverOrderModel.fromJson(Map<String, dynamic> json) => DriverOrderModel(
    paymentMethod: json["paymentMethod"] == null ? null : PaymentMethod.fromJson(json["paymentMethod"]),
    id: json["_id"],
    orderId: json["orderId"],
    userId: json["userId"],
    boutiqueId: json["boutiqueId"] == null ? null : BoutiqueId.fromJson(json["boutiqueId"]),
    orderItems: json["orderItems"] == null ? null : OrderItems.fromJson(json["orderItems"]),
    totalAmount: json["totalAmount"],
    serviceFee: json["serviceFee"],
    shippingFee: json["shippingFee"],
    tips: json["tips"],
    tax: json["tax"],
    subTotal: json["subTotal"],
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
    "boutiqueId": boutiqueId?.toJson(),
    "orderItems": orderItems?.toJson(),
    "totalAmount": totalAmount,
    "serviceFee": serviceFee,
    "shippingFee": shippingFee,
    "tips": tips,
    "tax": tax,
    "subTotal": subTotal,
    "status": status,
    "deliveryAddress": deliveryAddress,
    "assignedDriver": assignedDriver,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class BoutiqueId {
  dynamic assignedDriverProgress;
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
  dynamic oneTimeCode;
  int? v;
  CurrentLocation? currentLocation;

  BoutiqueId({
    this.assignedDriverProgress,
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
    this.currentLocation,
  });

  factory BoutiqueId.fromJson(Map<String, dynamic> json) => BoutiqueId(
    assignedDriverProgress: json["assignedDriverProgress"],
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
    currentLocation: json["currentLocation"] == null ? null : CurrentLocation.fromJson(json["currentLocation"]),
  );

  Map<String, dynamic> toJson() => {
    "assignedDriverProgress": assignedDriverProgress,
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

class OrderItems {
  String? id;
  List<OrederedProduct>? orederedProduct;
  String? orderId;
  int? v;

  OrderItems({
    this.id,
    this.orederedProduct,
    this.orderId,
    this.v,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
    id: json["_id"],
    orederedProduct: json["orederedProduct"] == null ? [] : List<OrederedProduct>.from(json["orederedProduct"]!.map((x) => OrederedProduct.fromJson(x))),
    orderId: json["orderId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orederedProduct": orederedProduct == null ? [] : List<dynamic>.from(orederedProduct!.map((x) => x.toJson())),
    "orderId": orderId,
    "__v": v,
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
