// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'contact_model.dart';

// UserModel getUserDefault() {
//   return UserModel(
//     role: 'User',
//   );
// }

class UserModel {
  String role;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Contact>? contact;

  UserModel({
    required this.role,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.contact,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        role: json["role"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        contact:
            List<Contact>.from(json["contact"].map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "createdAt": (createdAt ?? DateTime.now()).toIso8601String(),
        "updatedAt": (updatedAt ?? DateTime.now()).toIso8601String(),
        "contact": List<dynamic>.from(contact ?? [].map((x) => x.toJson())),
      };
}
