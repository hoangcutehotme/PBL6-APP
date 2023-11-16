import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/data/repository/user_respository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/StoreController/cart_controller.dart';
import '../data/api/api_client.dart';
import '../utils/api_endpoints.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiEndPoints.baseUrl));

  // Repo
  // Get.lazyPut(() => ProductRepo());
  Get.lazyPut(() => UserRespo(Get.find()));

  // Controller
  Get.lazyPut(() => UserController(sharedPreferences: Get.find(), respo: Get.find(),));
  // Get.put(() => CartController());
  // Get.lazyPut(() => StoreController());
  // Get.lazyPut(() => ProductController1(productRepo: Get.find()));
}
