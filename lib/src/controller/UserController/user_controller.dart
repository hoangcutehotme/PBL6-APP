import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var user = UserModel(role: 'User').obs;
  var id = ''.obs;
  var token = ''.obs;
  var isLoading = false.obs;

  final GlobalKey<FormState> changeInfoKey = GlobalKey<FormState>();

  late TextEditingController firstName,lastname,email,phone;

  // change info user
  // this.id,
  //   this.firstName,
  //   this.lastName,
  //   this.email,
  //   this.phoneNumber,
  //   this.createdAt,
  //   this.updatedAt,
  //   this.contact,
  @override
  void onInit() {
    super.onInit();
    getInfoUserById();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getIdToken() async {
    final SharedPreferences prefs = await _prefs;
    id.value = prefs.getString('id_user') ?? '';
    token.value = prefs.getString('token') ?? '';
    update();
  }

  Future<void> getInfoUserById() async {
    isLoading(true);
    try {
      await getIdToken();
      if (id.value == '') {
        isLoading(false);
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Ban chua dang ky!!!"),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/signup");
                      },
                      child: const Text("Đăng ký"))
                ],
                // children: [Text(e.toString())],
              );
            });
      } else {
        var cookies = token.value;

        var headers = {
          'Cookie': 'jwt=$cookies',
        };
        var url = Uri.parse("${ApiEndPoints.baseUrl}/user/${id.value}");

        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200) {
          // Map<String, dynamic> userJson = jsonDecode(response.body);
          user.value = UserModel.fromJson(jsonDecode(response.body));
          update();
          isLoading(false);
        } else {
          isLoading(false);
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Error"),
                  children: [Text(response.headers.toString())],
                );
              });
        }
      }
    } catch (e) {
      isLoading(false);
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
