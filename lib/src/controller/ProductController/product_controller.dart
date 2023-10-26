import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/temp.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  var client = http.Client();

  var list = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    var category = Get.arguments;
    String encodedCatName = Uri.encodeComponent(category.catName);
    fetchProductFromCategory(encodedCatName);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    list.value = [];
  }

  Future<void> fetchProductFromCategory(String name) async {
    isLoading(true);
    try {
      name = Uri.decodeComponent(name);
      var url = Uri.parse('${ApiEndPoints.baseUrl}/product?catName=$name');

      var response = await client.get(url);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = response.body;
        list.value = productModelFromJson(jsonEncode(json['data']['data']));
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Text("Error"),
                children: [Text('Not Success')],
              );
            });
      }
    } catch (e) {
      print(e.toString());
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
}
