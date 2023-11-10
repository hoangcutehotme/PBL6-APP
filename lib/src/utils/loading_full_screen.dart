import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

class LoadingFullScreen {
  static void showLoading() {
    Get.dialog(
      WillPopScope(
        child: const Center(child: CircularProgressIndicator()),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      // barrierColor: AppColors.mainColor1,
      useSafeArea: true,
    );
  }

  static void cancelLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
