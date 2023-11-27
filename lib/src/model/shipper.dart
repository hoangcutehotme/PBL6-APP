// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pbl6_app/src/model/contact_model.dart';
import 'package:pbl6_app/src/model/user_model.dart';

class Shipper extends UserModel {
  String? status;
  double? ratingsAverage;
  int? ratingsQuantity;
  String? vehicleNumber;
  String? vehicleType;
  String? licenseNumber;
  Shipper({
    this.ratingsAverage,
    this.ratingsQuantity,
    this.vehicleNumber,
    this.vehicleType,
    this.licenseNumber,
    this.status,
    String? photo,
    required role,
    List<Contact>? contact,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? defaultContact,
  }) : super(
          role: 'Shipper',
          photo: photo,
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          contact: contact,
          defaultContact: defaultContact,
        );

  factory Shipper.fromJson(Map<String, dynamic> json) => Shipper(
        status: json["status"],
        ratingsAverage: json["ratingsAverage"],
        ratingsQuantity: json["ratingsQuantity"],
        photo: json["photo"],
        role: json["role"],
        contact:
            List<Contact>.from(json["contact"].map((x) => Contact.fromJson(x))),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        vehicleNumber: json["vehicleNumber"],
        vehicleType: json["vehicleType"],
        licenseNumber: json["licenseNumber"],
        defaultContact: json["defaultContact"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "status": status,
        "ratingsAverage": ratingsAverage,
        "ratingsQuantity": ratingsQuantity,
        "photo": photo,
        "role": role,
        "contact": List<dynamic>.from(contact ?? [].map((x) => x.toJson())),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "vehicleNumber": vehicleNumber,
        "vehicleType": vehicleType,
        "licenseNumber": licenseNumber,
        "defaultContact": defaultContact,
        "createdAt": (createdAt ?? DateTime.now()).toIso8601String(),
        "updatedAt": (updatedAt ?? DateTime.now()).toIso8601String(),
      };
}
