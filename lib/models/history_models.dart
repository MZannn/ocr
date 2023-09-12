class HistoryModelResponse {
  int? code;
  String? status;
  String? message;
  List<HistoryModel>? data;

  HistoryModelResponse({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory HistoryModelResponse.fromJson(Map<String, dynamic> json) =>
      HistoryModelResponse(
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
  String? personToVisit;
  String? personAddress;
  String? personPhoneNumber;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  HistoryModel({
    this.id,
    this.identityNumber,
    this.name,
    this.address,
    this.phoneNumber,
    this.personToVisit,
    this.personAddress,
    this.personPhoneNumber,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        identityNumber: json["identity_number"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        personToVisit: json["person_to_visit"],
        personAddress: json["person_address"],
        personPhoneNumber: json["person_phone_number"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identity_number": identityNumber,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
        "person_to_visit": personToVisit,
        "person_address": personAddress,
        "person_phone_number": personPhoneNumber,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
