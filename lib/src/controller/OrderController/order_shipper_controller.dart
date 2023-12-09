import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/data/repository/order_repository.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../data/api/api_client.dart';
import '../../model/order_detail_shipper.dart';
import '../../model/shipper_order.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/custome_snackbar.dart';
import '../ShipperController/shipper_controller.dart';

class OrderShipperController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ShipperController shipperController;
  final OrderRepo orderRepo;

  OrderShipperController(
      {required this.orderRepo, required this.shipperController});

  List<OrderShipper> _listOrder = [];
  List<OrderShipper> get listOrder => _listOrder;

  OrderDetailShipper _orderShipper = OrderDetailShipper();
  OrderDetailShipper get orderShipper => _orderShipper;

  var isLoading = false.obs;
  var client = http.Client();

  getListOrder() async {
    try {
      ApiClient apiClient = Get.find();
      var id = shipperController.id.value;

      var url = "${ApiEndPoints.baseUrl}/shipper/$id/find-orders";

      await http
          .get(Uri.parse(url), headers: apiClient.header)
          .then((response) {
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          _listOrder = orderShipperFromJson(jsonEncode(json['data']));
          update();
        } else {
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context, title: "Error ", message: 'list order');
        }
      });
    } catch (e) {
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error ", message: '$e');
    }
  }

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

  Future changeStatusOrder(String idOrder) async {
    try {
      LoadingFullScreen.showLoading();
      var response = await orderRepo.changeStatusShipper(
          idOrder, shipperController.id.value);

      var jsonBody = jsonDecode(response.body);
      LoadingFullScreen.cancelLoading();
      if (response.statusCode == 200) {
        var status = jsonBody['data']['status'];
        _orderShipper.status = status;
        update();
        if (status == "Finished") {
          shipperController.updateOrderDetail(OrderDetailShipper());
        } else {
          shipperController.updateOrderDetail(_orderShipper);
        }
        return _orderShipper;
      } else {
        return false;
      }
    } catch (e) {
      LoadingFullScreen.cancelLoading();
      return false;
    } finally {
      // LoadingFullScreen.cancelLoading();
    }
  }
}
