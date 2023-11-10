import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  var otpValue = ''.obs;
  var isShowPass = true.obs;
  var isShowPassConfirm = true.obs;
  var isLoading = false.obs;

  var client = http.Client();

  void changeShowPassConfirm() {
    isShowPassConfirm.toggle();
  }

  void changeShowPass() {
    isShowPass.toggle();
  }

  forgotPasswordSendToEmail() async {
    isLoading(true);
    LoadingFullScreen.showLoading();
    try {
      print("forgot password");

      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${ApiEndPoints.baseUrl}/auth/forgot-password");

      var body = {
        "email": emailController.text.trim().toString(),
      };

      var response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("success");
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showSuccessSnackBar(
            context: Get.context,
            title: 'Success',
            message: json['message'].toString());
        
        return true;
      } else {
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: 'Error',
            message: json['message'].toString());
       
        return false;
      }
    } catch (e) {
      print(e.toString());
      LoadingFullScreen.cancelLoading();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Error', message: e.toString());
     
      return false;
    } finally {
      isLoading(false);
      LoadingFullScreen.cancelLoading();
    }
  }

  verifyTokenPassword(String otp) async {
    isLoading(true);
    LoadingFullScreen.showLoading();
    try {
      print("forgot password");

      var headers = {'Content-Type': 'application/json'};

      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}/auth/verify-token/${emailController.text.trim()}");
      otpValue.value = otp;

      var body = {
        "token": otp,
      };

      var response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (json['status'] != 400) {
          LoadingFullScreen.cancelLoading();
          print("success");
          CustomeSnackBar.showSuccessSnackBar(
              context: Get.context,
              title: 'Success',
              message: json['message'].toString());
          
          return true;
        } else {
          LoadingFullScreen.cancelLoading();
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context,
              title: 'Error',
              message: json['message'].toString());
          
          return false;
        }
      } else {
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: 'Error',
            message: json['message'].toString());
        
        return false;
      }
    } catch (e) {
      print(e.toString());
      LoadingFullScreen.cancelLoading();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Error', message: e.toString());
     
      return false;
    } finally {
      LoadingFullScreen.cancelLoading();
      isLoading(false);
    }
  }

  resetPassword() async {
    isLoading(true);
    LoadingFullScreen.showLoading();
    try {
      var headers = {'Content-Type': 'application/json'};

      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}/auth/reset-password/${emailController.text.trim()}");

      var body = {
        "token": otpValue.value.toString(),
        "password": passwordController.text.trim(),
        "passwordConfirm": passwordConfirmController.text.trim()
      };

      var response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("success");
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showSuccessSnackBar(
            context: Get.context,
            title: 'Success',
            message: json['message'].toString());
        
        return true;
      } else {
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: 'Error',
            message: json['message'].toString());
        
        return false;
      }
    } catch (e) {
      LoadingFullScreen.cancelLoading();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Error', message: e.toString());
      return false;
    } finally {
      isLoading(false);
      LoadingFullScreen.cancelLoading();
    }
  }
}
