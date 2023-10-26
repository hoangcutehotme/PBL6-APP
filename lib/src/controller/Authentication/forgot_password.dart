import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

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

        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Success"),
                children: [Center(child: Text(json['message'].toString()))],
              );
            });
        return true;
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Center(child: Text("Error")),
                children: [
                  Center(child: Text('404')),
                ],
              );
            });
        return false;
      }
    } catch (e) {
      print(e.toString());
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Thông báo"),
              children: [Center(child: Text(e.toString()))],
            );
          });
      return false;
    } finally {
      isLoading(false);
    }
  }

  verifyTokenPassword(String otp) async {
    isLoading(true);
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
          print("success");
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Success"),
                  children: [Center(child: Text(json['message'].toString()))],
                );
              });
          return true;
        } else {
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Error"),
                  children: [Center(child: Text(json['message'].toString()))],
                );
              });
          return false;
        }
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Center(child: Text("Error")),
                children: [
                  Center(child: Text('Lỗi kết nối')),
                ],
              );
            });
        return false;
      }
    } catch (e) {
      print(e.toString());
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Thông báo"),
              children: [Center(child: Text(e.toString()))],
            );
          });
      return false;
    } finally {
      isLoading(false);
    }
  }

  resetPassword() async {
    isLoading(true);
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
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Success"),
                children: [Center(child: Text(json['message'].toString()))],
              );
            });
        return true;
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Center(child: Text("Error")),
                children: [
                  Center(child: Text(json['message'].toString())),
                ],
              );
            });
        return false;
      }
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Thông báo"),
              children: [Center(child: Text(e.toString()))],
            );
          });
      return false;
    } finally {
      isLoading(false);
    }
  }
}
