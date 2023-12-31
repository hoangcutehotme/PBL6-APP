import 'dart:convert';

import 'package:pbl6_app/src/model/location_model.dart';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
    LocationCoordinate? location;
    String? id;
    String? address;
    String? phoneNumber;

    Contact({
        this.location,
         this.id,
        this.address,
        this.phoneNumber,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        location: json["location"] == null ? null : LocationCoordinate.fromJson(json["location"]),
        id: json["_id"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "address": address,
        "phoneNumber": phoneNumber,
    };
}