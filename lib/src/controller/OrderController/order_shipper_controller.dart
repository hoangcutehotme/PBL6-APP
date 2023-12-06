import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/data/repository/order_repository.dart';
import 'package:pbl6_app/src/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/order_detail_shipper.dart';
import '../ShipperController/shipper_controller.dart';

class OrderShipperController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ShipperController shipperController;
  final OrderRepo orderRepo;

  OrderShipperController(
      {required this.orderRepo, required this.shipperController});

  final List<OrderModel> _listOrder = [];
  List<OrderModel> get listOrder => _listOrder;

  OrderDetailShipper _orderShipper = OrderDetailShipper();
  OrderDetailShipper get orderShipper => _orderShipper;

  var isLoading = false.obs;
  var client = http.Client();

  Future<OrderDetailShipper?> showOrderDetail(String id) async {
    try {
      var response = await orderRepo.getOrderDetailShipper(id);

      var jsonBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var order = OrderDetailShipper.fromJson(jsonBody['data']);
        _orderShipper = order;
        update();
        return order;
      } else {
        return OrderDetailShipper();
      }
    } catch (e) {
      return OrderDetailShipper();
    }
  }

  changeStatusOrder(String idOrder, String idShipper) async {
    try {
      var response = await orderRepo.changeStatusShipper(idOrder, idShipper);

      var jsonBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }
}
