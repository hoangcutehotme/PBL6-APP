import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_endpoints.dart';
import '../../utils/custome_snackbar.dart';
import '../../utils/loading_full_screen.dart';
import 'package:http/http.dart' as http;

class UserChangePasswordController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late TextEditingController oldPassController,
      newPassController,
      confirmNewPassController;

  var isLoading = false.obs;

  var showOldPassword = false.obs;
  var showNewPassword = false.obs;
  var showConfirmPassword = false.obs;

  void toggleShowOldPassword() {
    showOldPassword.toggle();
  }

  void toggleShowNewPassword() {
    showNewPassword.toggle();
  }

  void toggleShowConfirmPassword() {
    showConfirmPassword.toggle();
  }

  @override
  Future<void> onInit() async {
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
    confirmNewPassController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    oldPassController.clear();
    newPassController.clear();
    confirmNewPassController.clear();
  }

  checkData() {
    if (oldPassController.text.isEmpty ||
        newPassController.text.isEmpty ||
        confirmNewPassController.text.isEmpty) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Error', message: 'Không được để trống');
      return false;
    }
    if (oldPassController.text.length < 8) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Mật khẩu hiện tại nhỏ hơn 8 kí tự');
      return false;
    } else if (newPassController.text.length < 8 ||
        confirmNewPassController.text.length < 8) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Mật khẩu mới nhỏ hơn 8 kí tự');
      return false;
    } else if (newPassController.text.length !=
        confirmNewPassController.text.length) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Mật khẩu nhập vào không khớp');
      return false;
    } else {
      return true;
    }
  }

  resetPassword() async {
    isLoading(true);
    LoadingFullScreen.showLoading();
    try {
      ApiClient apiClient = Get.find();
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}/user/change-pass/${Get.find<UserController>().id.value}");

      var body = {
        "oldPass": oldPassController.text.trim(),
        "newPass": newPassController.text.trim(),
        "confirmedPass": confirmNewPassController.text.trim()
      };

      var response = await http.post(url,
          body: jsonEncode(body), headers: apiClient.header);

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showSuccessSnackTopBar(
            context: Get.context,
            title: 'Success',
            message: 'Thay đổi mật khẩu thành công');

        return true;
      } else {
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showWarningTopBar(
            context: Get.context,
            title: 'Error',
            message: json['message'].toString());

        return false;
      }
    } catch (e) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Error', message: e.toString());
      return false;
    } finally {
      isLoading(false);
      LoadingFullScreen.cancelLoading();
    }
  }
}
