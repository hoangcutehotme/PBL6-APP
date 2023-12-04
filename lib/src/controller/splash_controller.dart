import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();

    SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token');
    var role = prefs.getString(AppString.ROLE);
    if (token != null) {
      if (role == 'User') {
        print('Token: $token');
        Get.offAllNamed("/home");
      } else if (role == "Shipper") {
        print('Token: $token');
        Get.offAllNamed("/shipperNaviPage");
      }
    } else {
      Get.offAllNamed('/signin');
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
