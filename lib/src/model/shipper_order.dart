import 'dart:convert';
import 'location_model.dart';

List<OrderShipper> orderShipperFromJson(String str) => List<OrderShipper>.from(
    json.decode(str).map((x) => OrderShipper.fromJson(x)));

String orderShipperToJson(List<OrderShipper> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderShipper {
  String? id;
  Location? storeLocation;
  String? status;
  double? dist;

  OrderShipper({
    this.id,
    this.storeLocation,
    this.status,
    this.dist,
  });

  factory OrderShipper.fromJson(Map<String, dynamic> json) => OrderShipper(
        id: json["_id"],
        storeLocation: Location.fromJson(json["storeLocation"]),
        status: json["status"],
        dist: json["dist"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "storeLocation": storeLocation?.toJson(),
        "status": status,
        "dist": dist,
      };
}
