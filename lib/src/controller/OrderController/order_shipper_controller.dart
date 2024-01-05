import 'dart:convert';
import 'package:get/get.dart';
import 'package:pbl6_app/src/data/repository/order_repository.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/values/app_string.dart';
import '../../data/api/api_client.dart';
import '../../model/order_detail_shipper.dart';
import '../../model/order_detail_shipper_2.dart';
import '../../model/shipper_order.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/custome_snackbar.dart';
import '../ShipperController/shipper_address_controllerd.dart';
import '../ShipperController/shipper_controller.dart';
import '../../helper/func/func_useful.dart';

class OrderShipperController extends GetxController {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ShipperController shipperController;
  final OrderRepo orderRepo;

  OrderShipperController(
      {required this.orderRepo, required this.shipperController});

  List<OrderShipper> _listOrder = [];
  List<OrderShipper> get listOrder => _listOrder;

  OrderDetailShipper _orderShipper = OrderDetailShipper();
  OrderDetailShipper get orderShipper => _orderShipper;

  List<OrderShipper2> _listOrderShipperInDay = [];
  List<OrderShipper2> get listOrderShipperInDay => _listOrderShipperInDay;

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
          CustomeSnackBar.showWarningTopBar(
              context: Get.context, title: "Error ", message: 'list order');
        }
      });
    } catch (e) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: "Error ", message: '$e');
    }
  }

  Future<OrderDetailShipper?> showOrderDetail(String id) async {
    try {
      var response = await orderRepo.getOrderDetail(id);

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
    LoadingFullScreen.showLoading();
    try {
      ShipperAddressController shipperAddressController = Get.find();
      var response = await orderRepo.changeStatusShipper(
          idOrder, shipperController.id.value);
      LoadingFullScreen.cancelLoading();
      var jsonBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var status = jsonBody['data']['status'];
        _orderShipper.status = status;
        update();
        if (status == "Finished" || status == "Refused") {
          await shipperController.updateOrderDetail(OrderDetailShipper());
          await shipperAddressController.removePolyPoints();
        } else if (status == AppString.statusOrder.keys.elementAt(0) ||
            status == AppString.statusOrder.keys.elementAt(1)) {
          await shipperController.updateOrderDetail(_orderShipper);
          print("get direction ");
        } else {
          await shipperController.updateOrderDetail(_orderShipper);
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

  getListOrderInDay(DateTime date) async {
    try {
      ApiClient apiClient = Get.find();
      var id = shipperController.id.value;
      var url =
          "${ApiEndPoints.baseUrl}/order/shipper/$id?end=${FuncUseful.stringDateTimeToDayMonthYear2(date)}&start=${FuncUseful.stringDateTimeToDayMonthYear2(date)}";
      var response = await http.get(Uri.parse(url), headers: apiClient.header);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _listOrderShipperInDay = [];
        update();
        _listOrderShipperInDay =
            orderShipper2FromJson(jsonEncode(json['data']));
        _listOrderShipperInDay = _listOrderShipperInDay.reversed.toList();
        update();
      } else {
        CustomeSnackBar.showWarningTopBar(
            context: Get.context, title: "Error ", message: '');
      }
    } catch (e) {
      print(e);
    }
  }
}
