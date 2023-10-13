// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pbl6_app/src/model/order_food_model.dart';

class OrderModel {
  int id;
  String nameStore;
  List<OrderFood> listOrder;
  double totalAmount;
  String user;
  DateTime? time;
  String address;

  OrderModel({
    required this.id,
    required this.nameStore,
    required this.listOrder,
    required this.totalAmount,
    required this.user,
    this.time,
    required this.address,
  });

  static OrderModel getOrder() {
    List<OrderFood> listFoodOrder = OrderFood.getListOrderFood();
    OrderModel order = OrderModel(
        id: 1,
        nameStore: "Bún đậu cô Tiên",
        listOrder: listFoodOrder,
        totalAmount: OrderModel.getAmount(listFoodOrder),
        user: "HuyLe",
        address: '193, Nguyễn Lương Bằng, Đà Nẵng');
    return order;
  }

  static double getAmount(List<OrderFood> list) {
    double count = 0;
    for (var i = 0; i < list.length; i++) {
      count += list[i].amount * list[i].food.price;
    }

    return count;
  }

  double getTotalAmount(OrderModel order) {
    double totalOrderAmount = 0;
    return totalOrderAmount;
  }
}
