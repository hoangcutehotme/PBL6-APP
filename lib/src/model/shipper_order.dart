import 'dart:convert';
import 'location_model.dart';

List<OrderShipper> orderShipperFromJson(String str) => List<OrderShipper>.from(
    json.decode(str).map((x) => OrderShipper.fromJson(x)));

String orderShipperToJson(List<OrderShipper> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderShipper {
  String? id;
  Location? storeLocation;
  Location? userLocation;
  String? status;
  double? dist;

  OrderShipper({
    this.id,
    this.storeLocation,
    this.userLocation,
    this.status,
    this.dist,
  });

  factory OrderShipper.fromJson(Map<String, dynamic> json) => OrderShipper(
        id: json["_id"],
        storeLocation: Location.fromJson(json["storeLocation"]),
        userLocation: Location.fromJson(json["userLocation"]),
        status: json["status"],
        dist: json["dist"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "storeLocation": storeLocation?.toJson(),
        "userLocation": userLocation?.toJson(),
        "status": status,
        "dist": dist,
      };
}
