import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.clear();
    passwordController.clear();
    passwordConfirmController.clear();
    firstnameController.clear();
    lastnameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  var isLoading = false.obs;
  var isShowPass = true.obs;
  var isShowPassConfirm = true.obs;

  var client = http.Client();

  // true is user, false is shipper
  var isUser = true.obs;

  void changeShowPassConfirm() {
    isShowPassConfirm.toggle();
  }

  void changeShowPass() {
    isShowPass.toggle();
  }

  void changeRole(String role) {
    if (role == "user") {
      isUser.value = true;

      update();
    } else if (role == "shipper") {
      isUser.value = false;
      // isSkip = RxBool(false);
      update();
    }
  }

  bool checkPassword() {
    if (passwordConfirmController.text == passwordController.text) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> registerUserEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${ApiEndPoints.baseUrl}/user");
      Map body = {
        "firstName": firstnameController.text.trim(),
        "lastName": lastnameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "passwordConfirm": passwordConfirmController.text,
        "address": addressController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
      };

      var response =
          await client.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (json['message'] == "Mã đã được gửi đến email!") {
          // emailController.clear();
          // passwordController.clear();
          // passwordConfirmController.clear();
          // firstnameController.clear();
          // lastnameController.clear();
          // addressController.clear();
          // phoneController.clear();
        } else {
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Error"),
                  children: [Text(json['message'])],
                );
              });
        }
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Text("Error"),
              );
            });
      }
    } catch (e) {
      // Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              children: [Text(e.toString())],
            );
          });
    }
  }

  verifyOtp(String otp) async {
    isLoading(true);
    try {
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl}/user/${emailController.text.trim()}');

      var body = {"signUpToken": otp.toString()};
      var response = await client.post(url, body: body);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Success"),
                children: [Text(json['message'])],
              );
            });
        onClose();
        return 'Success';
      } else {
        await showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Error"),
                children: [Text(json['message'])],
              );
            });
        return 'Error';
      }
    } catch (e) {
      await showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              children: [Text(e.toString())],
            );
          });
      return 'Fail';
    } finally {
      isLoading(false);
    }
  }
}
