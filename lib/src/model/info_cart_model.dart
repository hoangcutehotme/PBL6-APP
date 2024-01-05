
import 'dart:convert';
import 'contact_model.dart';

List<InfoCart> infoCartFromJson(String str) => List<InfoCart>.from(json.decode(str).map((x) => InfoCart.fromJson(x)));

String infoCartToJson(List<InfoCart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoCart {
    Contact? contact;
    int? deliveryTime;
    double? distance;
    int? shipCost;

    InfoCart({
        this.contact,
        this.deliveryTime,
        this.distance,
        this.shipCost,
    });

    factory InfoCart.fromJson(Map<String, dynamic> json) => InfoCart(
        contact: Contact.fromJson(json["contact"]),
        deliveryTime: json["deliveryTime"],
        distance: json["distance"],
        shipCost: json["shipCost"],
    );

    Map<String, dynamic> toJson() => {
        "contact": contact?.toJson(),
        "deliveryTime": deliveryTime,
        "distance": distance,
        "shipCost": shipCost,
    };
}
