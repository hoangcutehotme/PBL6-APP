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

  bool checkPassword() {
    if (passwordConfirmController.text == passwordController.text) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> registerEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${ApiEndPoints.baseUrl}user");
      Map body = {
        "firstName": firstnameController.text,
        "lastName": lastnameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "passwordConfirm": passwordConfirmController.text,
        "address": addressController.text,
        "phoneNumber": phoneController.text,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['message'] == "Token sent to email!") {
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();
          firstnameController.clear();
          lastnameController.clear();
          addressController.clear();
          phoneController.clear();
        } else {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
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
}
