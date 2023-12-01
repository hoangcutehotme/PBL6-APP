
import 'package:pbl6_app/src/model/cart_model.dart';

import 'location_model.dart';

class OrderShipper {
    Location? storeLocation;
    Location? userLocation;
    int? shipCost;
    int? totalPrice;
    String? status;
    String? id;
    String? user;
    String? store;
    List<CartModel>? cart;
    DateTime? dateOrdered;
    DateTime? createdAt;
    DateTime? updatedAt;

    OrderShipper({
        this.storeLocation,
        this.userLocation,
        this.shipCost,
        this.totalPrice,
        this.status,
        this.id,
        this.user,
        this.store,
        this.cart,
        this.dateOrdered,
        this.createdAt,
        this.updatedAt,
    });

    factory OrderShipper.fromJson(Map<String, dynamic> json) => OrderShipper(
        storeLocation: Location.fromJson(json["storeLocation"]),
        userLocation: Location.fromJson(json["userLocation"]),
        shipCost: json["shipCost"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        id: json["_id"],
        user: json["user"],
        store: json["store"],
        cart: List<CartModel>.from(json["cart"].map((x) => CartModel.fromJson(x))),
        dateOrdered: DateTime.parse(json["dateOrdered"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "storeLocation": storeLocation!.toJson(),
        "userLocation": userLocation!.toJson(),
        "shipCost": shipCost,
        "totalPrice": totalPrice,
        "status": status,
        "_id": id,
        "user": user,
        "store": store,
        "cart": List<dynamic>.from((cart??[]).map((x) => x.toJson())),
        "dateOrdered": dateOrdered!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
    };
}


