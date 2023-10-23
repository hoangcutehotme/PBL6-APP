import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isShowPass = true.obs;
  var isLoading = false.obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    isLoading(true);
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
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("success");

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
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Error"),
                  children: [Center(child: Text(json['status'].toString()))],
                );
              });
        }
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Center(child: Text("Error")),
                children: [
                  Center(child: Text('404')),
                  // Text(json['message'].toString()),
                ],
              );
            });
      }
    } catch (e) {
      print(e.toString());
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const SimpleDialog(
              title: Text("Thông báo"),
              children: [Center(child: Text('Chưa nhập email hoặc mật khẩu'))],
            );
          });
    } finally {
      isLoading(false);
    }
  }

  // Future<void> login() async {
  //   isLoading(true);

  //   showDialog(
  //       context: Get.context!,
  //       builder: (context) {
  //         return const Center(child: CircularProgressIndicator());
  //       });
  //   try {
  //     print("login");
  //     var headers = {'Content-Type': 'application/json'};
  //     var url = Uri.parse("${ApiEndPoints.baseUrl}/auth/login");
  //     var body = {
  //       "email": emailController.text.trim().toString(),
  //       "password": passwordController.text.toString()
  //     };

  //     http.Response response =
  //         await http.post(url, body: jsonEncode(body), headers: headers);

  //     if (response.statusCode == 200) {
  //       print("success");
  //       final json = jsonDecode(response.body);
  //       if (json['status'] == "success") {
  //         var token = json['token'];
  //         final SharedPreferences prefs = await _prefs;
  //         await prefs.setString('token', token);

  //         var user = json['data']['user'];
  //         // await FuncUseful.saveJson('user', user);
  //         // get id user
  //         print("id $user['_id]");
  //         prefs.setString('id_user', user['_id']);

  //         emailController.clear();
  //         passwordController.clear();

  //         Get.toNamed("/home");
  //       } else {
  //         showDialog(
  //             context: Get.context!,
  //             builder: (context) {
  //               return SimpleDialog(
  //                 title: const Text("Error"),
  //                 children: [Text(json['message'].toString())],
  //               );
  //             });
  //       }
  //     } else {
  //       throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     showDialog(
  //         context: Get.context!,
  //         builder: (context) {
  //           return SimpleDialog(
  //             title: const Text("Error"),
  //             children: [Text(e.toString())],
  //           );
  //         });
  //   } finally {
  //     isLoading(false);
  //     // Get.back();
  //     // Navigator.of(Get.context!).pop();
  //   }
  // }

  Future<void> logout() async {
    // Get.bot
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Get.offAllNamed('/signin');
  }

  void changeShowPass() {
    isShowPass.toggle();
  }
}
