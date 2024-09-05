

class DashBoardModel {
  int? activeOrders;
  int? compliteOrders;

  DashBoardModel({
    this.activeOrders,
    this.compliteOrders,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
    activeOrders: json["activeOrders"],
    compliteOrders: json["compliteOrders"],
  );

  Map<String, dynamic> toJson() => {
    "activeOrders": activeOrders,
    "compliteOrders": compliteOrders,
  };
}

