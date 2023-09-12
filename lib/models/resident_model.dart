class ResidentModelResponse {
  int? code;
  String? status;
  String? message;
  List<ResidentModel>? data;

  ResidentModelResponse({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory ResidentModelResponse.fromJson(Map<String, dynamic> json) =>
      ResidentModelResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ResidentModel>.from(
                json["data"]!.map((x) => ResidentModel.fromJson(x))),
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

class ResidentModel {
  String? identityNumber;
  String? name;
  String? address;
  String? phoneNumber;

  ResidentModel({
    this.identityNumber,
    this.name,
    this.address,
    this.phoneNumber,
  });

  factory ResidentModel.fromJson(Map<String, dynamic> json) => ResidentModel(
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
