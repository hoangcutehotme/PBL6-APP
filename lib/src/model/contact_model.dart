import 'dart:convert';

import 'package:pbl6_app/src/model/location_model.dart';

// class Contact {
//   String id;
//   String address;
//   String phoneNumber;
//   LocationModel? location;

//   Contact({
//     required this.id,
//     required this.address,
//     required this.phoneNumber,
//     this.location
//   });

//   factory Contact.fromJson(Map<String, dynamic> json) => Contact(
//         id: json["_id"],
//         address: json["address"],
//         phoneNumber: json["phoneNumber"],
//         location: json["location"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "address": address,
//         "phoneNumber": phoneNumber,
//         "location": location
//       };
// }


List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
    Location location;
    String id;
    String address;
    String phoneNumber;

    Contact({
        required this.location,
        required this.id,
        required this.address,
        required this.phoneNumber,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        location: Location.fromJson(json["location"]),
        id: json["_id"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "_id": id,
        "address": address,
        "phoneNumber": phoneNumber,
    };
}