class HistoryResponseModel {
  int? code;
  String? status;
  String? message;
  List<HistoryModel>? data;

  HistoryResponseModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory HistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      HistoryResponseModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HistoryModel>.from(
                json["data"]!.map((x) => HistoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HistoryModel {
  int? id;
  String? identityNumber;
  String? name;
  String? address;
  String? phoneNumber;
  int? residentsId;
  String? status;
  String? photo;
  String? createdAt;
  String? updatedAt;
  Resident? resident;

  HistoryModel({
    this.id,
    this.identityNumber,
    this.name,
    this.address,
    this.phoneNumber,
    this.residentsId,
    this.status,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.resident,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        identityNumber: json["identity_number"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        residentsId: json["residents_id"],
        status: json["status"],
        photo: json["photo"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        resident: json["resident"] == null
            ? null
            : Resident.fromJson(json["resident"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identity_number": identityNumber,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
        "residents_id": residentsId,
        "status": status,
        "photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "resident": resident?.toJson(),
      };
}

class Resident {
  String? identityNumber;
  String? name;
  String? address;
  String? phoneNumber;

  Resident({
    this.identityNumber,
    this.name,
    this.address,
    this.phoneNumber,
  });

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
        identityNumber: json["identity_number"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "identity_number": identityNumber,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
      };
}
