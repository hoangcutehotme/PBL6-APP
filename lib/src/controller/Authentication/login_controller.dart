import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/func/func_useful.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      print("login");
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${ApiEndPoints.baseUrl}/auth/login");
      var body = {
        "email": emailController.text.trim().toString(),
        "password": passwordController.text.toString()
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        print("success");
        final json = jsonDecode(response.body);
        if (json['status'] == "success") {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          var user = json['data']['user'];
          // await FuncUseful.saveJson('user', user);
          // get id user
          print("id $user['_id]");
          prefs.setString('id_user', user['_id']);

          emailController.clear();
          passwordController.clear();

          Get.toNamed("/home");
        } else {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
      }
    } catch (e) {
      print(e);
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

  Future<void> logout() async {
    // Get.bot
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Get.offAllNamed('/signin');
  }
}
