

import 'dart:convert';

import 'package:pbl6_app/src/model/store_model.dart';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    int? totalPrice;
    String? status;
    String? id;
    StoreModel? store;
    DateTime? dateOrdered;

    OrderModel({
        this.totalPrice,
        this.status,
        this.id,
        this.store,
        this.dateOrdered,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        totalPrice: json["totalPrice"],
        status: json["status"],
        id: json["_id"],
        store: StoreModel.fromJson(json["store"]),
        dateOrdered: DateTime.parse(json["dateOrdered"]),
    );

    Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "status": status,
        "_id": id,
        "store": store!.toJson(),
        "dateOrdered": dateOrdered!.toIso8601String(),
    };
}
