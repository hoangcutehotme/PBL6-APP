import 'contact_model.dart';

class UserModel {
  String? role;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Contact>? contact;
  String? defaultContact;
  String? photo;
  UserModel(
      {this.role,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.contact,
      this.defaultContact,
      this.photo});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        role: json["role"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        contact: json["contact"] == null
            ? null
            : List<Contact>.from(
                json["contact"].map((x) => Contact.fromJson(x))),
        defaultContact: json["defaultContact"],
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "createdAt": (createdAt ?? DateTime.now()).toIso8601String(),
        "updatedAt": (updatedAt ?? DateTime.now()).toIso8601String(),
        "contact": List<dynamic>.from(contact ?? [].map((x) => x.toJson())),
        "defaultContact": defaultContact,
        "photo": photo,
      };
}
