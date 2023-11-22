

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


// class OrderModel {
//   int id;
//   String nameStore;
//   List<OrderFood> listOrder;
//   double totalAmount;
//   String user;
//   DateTime? time;
//   String address;

//   OrderModel({
//     required this.id,
//     required this.nameStore,
//     required this.listOrder,
//     required this.totalAmount,
//     required this.user,
//     this.time,
//     required this.address,
//   });

//   static OrderModel getOrder() {
//     List<OrderFood> listFoodOrder = OrderFood.getListOrderFood();
//     OrderModel order = OrderModel(
//         id: 1,
//         nameStore: "Bún đậu cô Tiên",
//         listOrder: listFoodOrder,
//         totalAmount: OrderModel.getAmount(listFoodOrder),
//         user: "HuyLe",
//         address: '193, Nguyễn Lương Bằng, Đà Nẵng');
//     return order;
//   }

//   static double getAmount(List<OrderFood> list) {
//     double count = 0;
//     for (var i = 0; i < list.length; i++) {
//       count += list[i].amount * list[i].food.price;
//     }

//     return count;
//   }

//   double getTotalAmount(OrderModel order) {
//     double totalOrderAmount = 0;
//     return totalOrderAmount;
//   }
// }
