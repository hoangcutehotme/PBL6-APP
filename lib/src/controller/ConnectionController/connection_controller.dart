import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(
          'Mất kết nối Internet',
          style: AppStyles.textSemiBold,
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: AppColors.mainColor1,
        icon: const Icon(
          Icons.wifi_off_outlined,
          color: AppColors.mainColorBackground,
          size: 30,
        ),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
