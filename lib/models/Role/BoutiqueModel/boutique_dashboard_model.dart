

class BoutiqueDashBoardModel {
  ActiveOrder? activeOrder;
  ActiveOrder? compliteOrder;
  ActiveOrder? reciveOrder;
  ActiveOrder? totalOrdar;

  BoutiqueDashBoardModel({
    this.activeOrder,
    this.compliteOrder,
    this.reciveOrder,
    this.totalOrdar,
  });

  factory BoutiqueDashBoardModel.fromJson(Map<String, dynamic> json) => BoutiqueDashBoardModel(
    activeOrder: json["activeOrder"] == null ? null : ActiveOrder.fromJson(json["activeOrder"]),
    compliteOrder: json["compliteOrder"] == null ? null : ActiveOrder.fromJson(json["compliteOrder"]),
    reciveOrder: json["reciveOrder"] == null ? null : ActiveOrder.fromJson(json["reciveOrder"]),
    totalOrdar: json["totalOrdar"] == null ? null : ActiveOrder.fromJson(json["totalOrdar"]),
  );

  Map<String, dynamic> toJson() => {
    "activeOrder": activeOrder?.toJson(),
    "compliteOrder": compliteOrder?.toJson(),
    "reciveOrder": reciveOrder?.toJson(),
    "totalOrdar": totalOrdar?.toJson(),
  };
}

class ActiveOrder {
  int? totalOrder;
  String? totalAmount;

  ActiveOrder({
    this.totalOrder,
    this.totalAmount,
  });

  factory ActiveOrder.fromJson(Map<String, dynamic> json) => ActiveOrder(
    totalOrder: json["totalOrder"],
    totalAmount: json["totalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "totalOrder": totalOrder,
    "totalAmount": totalAmount,
  };
}

