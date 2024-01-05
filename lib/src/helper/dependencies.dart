import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ConnectionController/connection_controller.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/controller/ShipperController/statistic_order_shipper_controller.dart';
import 'package:pbl6_app/src/controller/StoreController/voucher_controller.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/data/repository/order_static_repository.dart';
import 'package:pbl6_app/src/data/repository/shipper_respository.dart';
import 'package:pbl6_app/src/data/repository/user_respository.dart';
import 'package:pbl6_app/src/data/repository/voucher_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/OrderController/order_user_controller.dart';
import '../controller/OrderController/order_shipper_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/order_repository.dart';
import '../utils/api_endpoints.dart';

Future<void> init() async {
  Get.put<ConnectionController>(ConnectionController(), permanent: true);
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: ApiEndPoints.baseUrl, sharedPreferences: Get.find()));

  // Repo
  Get.lazyPut(() => UserRespo(apiClient: Get.find()));
  Get.lazyPut(() => ShipperRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderStatisticRepo(apiClient: Get.find()));
  Get.lazyPut(() => VoucherRepo());

  // Controller
  Get.lazyPut(
    () => UserController(
      respo: Get.find(),
    ),
  );

  Get.lazyPut(
    () => StaticOrderShipperController(orderStatisticRepo: Get.find()),
  );

  Get.lazyPut(() => OrderShipperController(
        orderRepo: Get.find(),
        shipperController: Get.find(),
      ));
  Get.lazyPut(
      () => OrderController(orderRepo: Get.find(), userController: Get.find()));

  Get.lazyPut(
    () => ShipperController(shipperRepo: Get.find()),
  );

  Get.lazyPut(() => VoucherController(voucherRepo: Get.find()));
}
