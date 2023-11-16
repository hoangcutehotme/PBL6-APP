import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isShowPass = true.obs;
  var isLoading = false.obs;
  var client = http.Client();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        String idToken = (await user.authentication).idToken!;
        await _authenticateWithApi(idToken);
        print("Success");
      } else {
        print("Eroro");
      }
    } catch (error) {
      // Handle sign-in errors
      print('Error signing in with Google: $error');
    }
  }

  Future<void> _authenticateWithApi(String idToken) async {
    try {
      var url = Uri.parse("${ApiEndPoints.baseUrl}/auth/google");
      var response = await client.post(
        url,
        body: {'idToken': idToken},
      );

      // Handle the response from the API
      print('API Response: ${response.body}');
      // Navigate to the next screen or perform necessary actions based on the API response
    } catch (error) {
      // Handle API request errors
      print('API Error: $error');
    }
  }

  Future<void> loginGoogle() async {
    isLoading(true);
    try {
      print("login google ");
      var url = Uri.parse("${ApiEndPoints.baseUrl}/auth/google");

      var response = await client.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        print("success");
      } else {
        print("no success");
      }

      // if (json['status'] == "success") {
      //   var token = json['token'];
      //   final SharedPreferences prefs = await _prefs;
      //   await prefs.setString('token', token);

      //   var user = json['data']['user'];
      //   // await FuncUseful.saveJson('user', user);
      //   // get id user
      //   print("id $user['_id]");
      //   prefs.setString('id_user', user['_id']);

      //   emailController.clear();
      //   passwordController.clear();

      //   Get.toNamed("/home");
      // } else {
      //   showDialog(
      //       context: Get.context!,
      //       builder: (context) {
      //         return SimpleDialog(
      //           title: const Text("Error"),
      //           children: [Center(child: Text(json['status'].toString()))],
      //         );
      //       });
      // }
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              children: [Text(e.toString())],
            );
          });
    } finally {
      isLoading(false);
    }
  }

  Future<void> login() async {
    isLoading(true);
    LoadingFullScreen.showLoading();
    try {
      print("login");
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${ApiEndPoints.baseUrl}/auth/login");
      var body = {
        "email": emailController.text.trim().toString(),
        "password": passwordController.text.toString()
      };

      var response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("success");

        if (json['status'] == "success") {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          ApiClient apiClient = Get.find();
          apiClient.updateHeader(token);
          apiClient.saveToken(token);

          var user = json['data']['user'];
          // await FuncUseful.saveJson('user', user);
          // get id user
          print("id $user['_id]");
          prefs.setString('id_user', user['_id']);
          LoadingFullScreen.cancelLoading();

          emailController.clear();
          passwordController.clear();

          CustomeSnackBar.showSuccessSnackBar(
              context: Get.context,
              title: "Success",
              message: "Đăng nhập thành công");

          Get.offAllNamed("/home");
        } else {
          LoadingFullScreen.cancelLoading();
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context,
              title: "Error",
              message: 'Sai tài khoản, mật khẩu');
        }
      } else {
        LoadingFullScreen.cancelLoading();
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: "Error",
            message: json['message'].toString());
      }
    } catch (e) {
      print(e.toString());
      LoadingFullScreen.cancelLoading();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: "");
    } finally {
      LoadingFullScreen.cancelLoading();
      isLoading(false);
    }
  }

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
