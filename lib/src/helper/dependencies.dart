import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/bottom_navi_bar_controller.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: ApiEndPoints.baseUrl));

  // Get.lazyPut(() => UserController(apiClient: Get.find()));

  
}
