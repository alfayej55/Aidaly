
class InboxChatModel {
  String? id;
  String? chatId;
  String? senderId;
  String? reciverId;
  String? textMessage;
  String? messageType;
  MessageImage? messageImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  InboxChatModel({
    this.id,
    this.chatId,
    this.senderId,
    this.reciverId,
    this.textMessage,
    this.messageType,
    this.messageImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory InboxChatModel.fromJson(Map<String, dynamic> json) => InboxChatModel(
    id: json["_id"],
    chatId: json["chatId"],
    senderId: json["senderId"],
    reciverId: json["reciverId"],
    textMessage: json["textMessage"],
    messageType: json["messageType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    messageImage: json["messageImage"] == null ? null : MessageImage.fromJson(json["messageImage"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatId": chatId,
    "senderId": senderId,
    "reciverId": reciverId,
    "textMessage": textMessage,
    "messageType": messageType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "messageImage": messageImage?.toJson(),
    "__v": v,
  };
}

class MessageImage {
  String? publicFileUrl;
  String? path;

  MessageImage({
    this.publicFileUrl,
    this.path,
  });

  factory MessageImage.fromJson(Map<String, dynamic> json) => MessageImage(
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




