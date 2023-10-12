import 'package:pbl6_app/src/model/order_food_model.dart';

class OrderModel {
  int id;
  String nameStore;
  List<OrderFood> listOrder;
  double totalAmount;
  String user;
  DateTime? time;

  OrderModel({
    required this.id,
    required this.nameStore,
    required this.listOrder,
    required this.totalAmount,
    required this.user,
    this.time,
  });

  double getTotalAmount(OrderModel order) {
    double totalOrderAmount = 0;
    return totalOrderAmount;
  }
}
