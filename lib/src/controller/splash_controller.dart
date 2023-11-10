import 'package:get/get.dart';
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
    // Get.testMode = true;
    final token = prefs.getString('token');

    if (token != null) {
      print('Token: $token');
      Get.offAllNamed("/home");
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
