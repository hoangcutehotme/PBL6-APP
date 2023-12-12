import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class CustomeSnackBar {
  static void showErrorSnackBar(
      {required BuildContext? context,
      required String title,
      required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.mainColor1,
      titleText: Text(
        title,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      messageText: Text(
        message,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      colorText: AppColors.mainColorBackground,
      borderRadius: 8,
      icon: const Icon(
        Icons.error_outline,
        color: AppColors.mainColorBackground,
      ),
      duration: const Duration(seconds: 4),
    );
  }

  static void showSuccessSnackBar(
      {required BuildContext? context,
      required String title,
      required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.colorSuccess,
      titleText: Text(
        title,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      messageText: Text(
        message,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      colorText: AppColors.mainColorBackground,
      borderRadius: 8,
      icon: const Icon(
        Icons.error_outline,
        color: AppColors.mainColorBackground,
      ),
      duration: const Duration(seconds: 4),
    );
  }

  static void showSuccessSnackTopBar(
      {required BuildContext? context,
      required String title,
      required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.colorSuccess,
      titleText: Text(
        title,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      messageText: Text(
        message,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      colorText: AppColors.mainColorBackground,
      borderRadius: 8,
      icon: const Icon(
        Icons.error_outline,
        color: AppColors.mainColorBackground,
      ),
      duration: const Duration(seconds: 1),
    );
  }

  static void showMessageTopBar(
      {required BuildContext? context,
      required String title,
      required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color.fromARGB(255, 57, 95, 233),
      titleText: Text(
        title,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      messageText: Text(
        message,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      colorText: AppColors.mainColorBackground,
      borderRadius: 8,
      icon: const Icon(
        Icons.error_outline,
        color: AppColors.mainColorBackground,
      ),
      duration: const Duration(seconds: 1),
    );
  }

  static void showWarningTopBar(
      {required BuildContext? context,
      required String title,
      required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.mainColor1,
      titleText: Text(
        title,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      messageText: Text(
        message,
        style:
            AppStyles.textMedium.copyWith(color: AppColors.mainColorBackground),
      ),
      colorText: AppColors.mainColorBackground,
      borderRadius: 8,
      icon: const Icon(
        Icons.error_outline,
        color: AppColors.mainColorBackground,
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
