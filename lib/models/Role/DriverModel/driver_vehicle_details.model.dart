
class DriverVehicleModel {
  String? id;
  String? userId;
  String? make;
  String? model;
  String? year;
  DriverLicense? driverLicense;
  DriverLicense? registration;
  DriverLicense? policeCheck;
  String? registrationNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DriverVehicleModel({
    this.id,
    this.userId,
    this.make,
    this.model,
    this.year,
    this.driverLicense,
    this.registration,
    this.policeCheck,
    this.registrationNumber,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DriverVehicleModel.fromJson(Map<String, dynamic> json) => DriverVehicleModel(
    id: json["_id"],
    userId: json["userId"],
    make: json["make"],
    model: json["model"],
    year: json["year"],
    driverLicense: json["driverLicense"] == null ? null : DriverLicense.fromJson(json["driverLicense"]),
    registration: json["registration"] == null ? null : DriverLicense.fromJson(json["registration"]),
    policeCheck: json["policeCheck"] == null ? null : DriverLicense.fromJson(json["policeCheck"]),
    registrationNumber: json["registrationNumber"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "make": make,
    "model": model,
    "year": year,
    "driverLicense": driverLicense?.toJson(),
    "registration": registration?.toJson(),
    "policeCheck": policeCheck?.toJson(),
    "registrationNumber": registrationNumber,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class DriverLicense {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  String? destination;
  String? filename;
  String? path;
  int? size;

  DriverLicense({
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.destination,
    this.filename,
    this.path,
    this.size,
  });

  factory DriverLicense.fromJson(Map<String, dynamic> json) => DriverLicense(
    fieldname: json["fieldname"],
    originalname: json["originalname"],
    encoding: json["encoding"],
    mimetype: json["mimetype"],
    destination: json["destination"],
    filename: json["filename"],
    path: json["path"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "fieldname": fieldname,
    "originalname": originalname,
    "encoding": encoding,
    "mimetype": mimetype,
    "destination": destination,
    "filename": filename,
    "path": path,
    "size": size,
  };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
