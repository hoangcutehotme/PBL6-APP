import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import '../../model/temp.dart';

class StoreController extends GetxController {
  var isLoading = false.obs;

  List<ProductModel> list = <ProductModel>[].obs;

  Future<void> fetchStoreList(String name) async {
    isLoading(true);
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}/product?$name');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        list = productModelFromJson(json);
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
