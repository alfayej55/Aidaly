
class EarnModel {
  int? totalEarnign;
  double? earnThisMonth;

  EarnModel({
    this.totalEarnign,
    this.earnThisMonth,
  });

  factory EarnModel.fromJson(Map<String, dynamic> json) => EarnModel(
    totalEarnign: json["totalEarnign"],
    earnThisMonth: json["earnThisMonth"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalEarnign": totalEarnign,
    "earnThisMonth": earnThisMonth,
  };
}

