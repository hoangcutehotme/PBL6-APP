import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StoreController extends GetxController {
  var isLoading = false.obs;

  var listStore = <StoreModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStores();
  }

  Future<void> fetchStores() async {
    isLoading(true);
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}/store');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        listStore.value = storeModelFromJson(jsonEncode(json['data']));
        
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
