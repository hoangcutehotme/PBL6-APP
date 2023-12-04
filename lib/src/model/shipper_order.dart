import 'dart:convert';

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

  statusShipper(String status) {
    return status == "Pending"
        ? "Đang xử lý"
        : (status == "Refused" ? "Từ chối đơn hàng" : "Đang xử lý");
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from((coordinates ?? []).map((x) => x)),
      };
}
