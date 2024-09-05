

class BoutiqueTrackModel {
  PaymentMethod? paymentMethod;
  String? id;
  String? orderId;
  AssignedDriver? userId;
  AssignedDriver? boutiqueId;
  OrderItems? orderItems;
  String? totalAmount;
  String? serviceFee;
  String? shippingFee;
  String? tips;
  String? tax;
  String? subTotal;
  String? status;
  String? deliveryAddress;
  String? assignedDriverProgress;
  String? assignedDrivertrack;
  AssignedDriver? assignedDriver;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BoutiqueTrackModel({
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
    this.assignedDriverProgress,
    this.assignedDrivertrack,
    this.assignedDriver,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BoutiqueTrackModel.fromJson(Map<String, dynamic> json) => BoutiqueTrackModel(
    paymentMethod: json["paymentMethod"] == null ? null : PaymentMethod.fromJson(json["paymentMethod"]),
    id: json["_id"],
    orderId: json["orderId"],
    userId: json["userId"] == null ? null : AssignedDriver.fromJson(json["userId"]),
    boutiqueId: json["boutiqueId"] == null ? null : AssignedDriver.fromJson(json["boutiqueId"]),
    orderItems: json["orderItems"] == null ? null : OrderItems.fromJson(json["orderItems"]),
    totalAmount: json["totalAmount"],
    serviceFee: json["serviceFee"],
    shippingFee: json["shippingFee"],
    tips: json["tips"],
    tax: json["tax"],
    subTotal: json["subTotal"],
    status: json["status"],
    deliveryAddress: json["deliveryAddress"],
    assignedDriverProgress: json["assignedDriverProgress"],
    assignedDrivertrack: json["assignedDrivertrack"],
    assignedDriver: json["assignedDriver"] == null ? null : AssignedDriver.fromJson(json["assignedDriver"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "paymentMethod": paymentMethod?.toJson(),
    "_id": id,
    "orderId": orderId,
    "userId": userId?.toJson(),
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
    "assignedDriverProgress": assignedDriverProgress,
    "assignedDrivertrack": assignedDrivertrack,
    "assignedDriver": assignedDriver?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class AssignedDriver {
  String? id;
  String? name;
  String? email;
  String? dateOfBirth;
  String? phone;
  String? address;
  String? city;
  String? rating;
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
  String? rate;
  String? description;

  AssignedDriver({
    this.id,
    this.name,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.address,
    this.city,
    this.rating,
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
    this.rate,
    this.description,
  });

  factory AssignedDriver.fromJson(Map<String, dynamic> json) => AssignedDriver(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    dateOfBirth: json["dateOfBirth"],
    phone: json["phone"],
    address: json["address"],
    city: json["city"],
    rating: json["rating"],
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
    rate: json["rate"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "dateOfBirth": dateOfBirth,
    "phone": phone,
    "address": address,
    "city": city,
    "rating": rating,
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
    "rate": rate,
    "description": description,
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
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
