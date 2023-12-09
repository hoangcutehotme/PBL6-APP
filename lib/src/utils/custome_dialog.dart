import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class CustomeDialog {
  static void showCustomeDialog({
    required BuildContext? context,
    required String title,
    required String message,
    required String confirmText,
    required Function() pressConfirm,
  }) {
    Get.defaultDialog(
      buttonColor: AppColors.mainColor1,
      title: title,
      middleText: message,
      titleStyle:
          AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      textCancel: 'Huỷ',
      // onCancel: () {
      //   Get.back();
      // },
      textConfirm: confirmText,
      radius: 10,
      onConfirm: pressConfirm,
    );
  }

  static void showCustomDialog1({
    required BuildContext context,
    required String title,
    required String message,
    required Function() pressConfirm,
  }) {
    Get.back(); // Close any previously opened dialogs
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the current dialog
            },
            child: const Text('Thoát'),
          ),
          TextButton(
            onPressed: () {
              pressConfirm();
              Get.back(); // Close the dialog after the confirmation action
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
