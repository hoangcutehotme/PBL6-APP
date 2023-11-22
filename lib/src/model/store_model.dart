//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) =>
    List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
  num? ratingAverage;
  String? image;
  bool? isLocked;
  String? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? openAt;
  String? closeAt;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? ownerId;
  // String? registrationLicense;

  StoreModel({
    this.ratingAverage,
    this.image,
    this.isLocked,
    this.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.openAt,
    this.closeAt,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.ownerId,
    // this.registrationLicense,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        ratingAverage: json["ratingsAverage"],
        image: json["image"],
        isLocked: json["isLocked"],
        id: json["_id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        openAt: json["openAt"],
        closeAt: json["closeAt"],
        description: json["description"],
        // createdAt: json["createdAt"] DateTime.parse(json["createdAt"]) ,
        // updatedAt: DateTime.parse(json["updatedAt"]),
        ownerId: json["ownerId"],
        // registrationLicense: json["registrationLicense"],
      );

  Map<String, dynamic> toJson() => {
        "ratingsAverage": ratingAverage,
        "images": image,
        "isLocked": isLocked,
        "_id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "openAt": openAt,
        "closeAt": closeAt,
        "description": description,
        // "createdAt": createdAt?.toIso8601String(),
        // "updatedAt": updatedAt?.toIso8601String(),
        "ownerId": ownerId,
        // "registrationLicense": registrationLicense,
      };
}
