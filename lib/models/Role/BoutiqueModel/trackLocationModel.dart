//
//
// class TrackLocationModel{
//   double? latitude;
//   double? longitude;
//   String? status;
//   String? assignedDrivertrack;
//
//   TrackLocationModel({this.latitude,this.longitude,this.status,this.assignedDrivertrack});
//
//   factory TrackLocationModel.fromJson(Map<String, dynamic> json) => TrackLocationModel(
//
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     status: json["status"],
//     assignedDrivertrack: json["assignedDrivertrack"],
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "latitude": latitude,
//     "longitude": longitude,
//     "status": status,
//     "assignedDrivertrack": assignedDrivertrack,
//   };
//
// }


// To parse this JSON data, do
//
//     final trackLocationModel = trackLocationModelFromJson(jsonString);


class TrackLocationModel {
  String? orderId;
  String? status;
  String? assignedDrivertrack;
  String? deliveryTime;
  Location? location;

  TrackLocationModel({
    this.orderId,
    this.status,
    this.assignedDrivertrack,
    this.deliveryTime,
    this.location,
  });

  factory TrackLocationModel.fromJson(Map<String, dynamic> json) => TrackLocationModel(
    orderId: json["orderId"],
    status: json["status"],
    assignedDrivertrack: json["assignedDrivertrack"],
    deliveryTime: json["deliveryTime"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "status": status,
    "assignedDrivertrack": assignedDrivertrack,
    "deliveryTime": deliveryTime,
    "location": location?.toJson(),
  };
}

class Location {
  String? userId;
  double? latitude;
  double? longitude;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Location({
    this.userId,
    this.latitude,
    this.longitude,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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
