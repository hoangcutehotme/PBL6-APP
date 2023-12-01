import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/data/repository/shipper_respository.dart';
import 'package:pbl6_app/src/data/repository/user_respository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/api_client.dart';
import '../data/repository/order_repository.dart';
import '../utils/api_endpoints.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: ApiEndPoints.baseUrl, sharedPreferences: Get.find()));

  // Repo
  Get.lazyPut(() => UserRespo(apiClient: Get.find()));
  Get.lazyPut(() => ShipperRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(
    () => UserController(
      respo: Get.find(),
    ),
  );

  Get.lazyPut(
    () => ShipperController(shipperRepo: Get.find()),
  );
}
