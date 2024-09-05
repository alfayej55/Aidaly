
class MassageListModel {
  String? chatId;
  OtherParticipantId? otherParticipantId;
  DateTime? updatedAt;
  String? lastMessage;

  MassageListModel({
    this.chatId,
    this.otherParticipantId,
    this.updatedAt,
    this.lastMessage,
  });

  factory MassageListModel.fromJson(Map<String, dynamic> json) => MassageListModel(
    chatId: json["chatId"],
    otherParticipantId: json["otherParticipantId"] == null ? null : OtherParticipantId.fromJson(json["otherParticipantId"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    lastMessage: json["lastMessage"],
  );

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "otherParticipantId": otherParticipantId?.toJson(),
    "updatedAt": updatedAt?.toIso8601String(),
    "lastMessage": lastMessage,
  };
}

class OtherParticipantId {
  int? boutiquePersentage;
  String? id;
  String? name;
  String? email;
  String? password;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OtherParticipantId({
    this.boutiquePersentage,
    this.id,
    this.name,
    this.email,
    this.password,
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
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OtherParticipantId.fromJson(Map<String, dynamic> json) => OtherParticipantId(
    boutiquePersentage: json["boutiquePersentage"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "boutiquePersentage": boutiquePersentage,
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
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
