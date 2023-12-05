import 'package:pbl6_app/src/model/cart_model.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/model/user_model.dart';

import 'contact_model.dart';
import 'location_model.dart';

class OrderDetailShipper {
    String? id;
    Location? storeLocation;
    int? shipCost;
    int? totalPrice;
    String? status;
    UserModel? user;
    List<CartModel>? cart;
    Contact? contact;
    DateTime? dateOrdered;
    StoreModel? store;
    int? depreciationShip;
    int? revenue;

    OrderDetailShipper({
        this.id,
        this.storeLocation,
        this.shipCost,
        this.totalPrice,
        this.status,
        this.user,
        this.cart,
        this.contact,
        this.dateOrdered,
        this.store,
        this.depreciationShip,
        this.revenue,
    });

    factory OrderDetailShipper.fromJson(Map<String, dynamic> json) => OrderDetailShipper(
        id: json["_id"],
        storeLocation: Location.fromJson(json["storeLocation"]),
        shipCost: json["shipCost"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        user: UserModel.fromJson(json["user"]),
        cart: List<CartModel>.from(json["cart"].map((x) => CartModel.fromJson(x))),
        contact: Contact.fromJson(json["contact"]),
        dateOrdered: DateTime.parse(json["dateOrdered"]),
        store: StoreModel.fromJson(json['store']),
        depreciationShip: json["depreciationShip"],
        revenue: json["revenue"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "storeLocation": storeLocation?.toJson(),
        "shipCost": shipCost,
        "totalPrice": totalPrice,
        "status": status,
        "user": user?.toJson(),
        "cart": List<dynamic>.from(cart?? [].map((x) => x.toJson())),
        "contact": contact?.toJson(),
        "dateOrdered": dateOrdered?.toIso8601String(),
        "store": store?.toJson(),
        "depreciationShip": depreciationShip,
        "revenue": revenue,
    };
}

