import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/custome_snackbar.dart';

import '../../utils/api_endpoints.dart';

class SearchFoodStoreController extends GetxController {
  TextEditingController search = TextEditingController();
  var client = http.Client();
  // var list = [].obs;

  Future<List<Map<String, dynamic>>> searchFoodAndStore(String query) async {
    try {
      var url =
          Uri.parse('${ApiEndPoints.baseUrl}/product/search?search=$query');

      var response = await client.get(url);

      Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 200) {
        List<dynamic> bodyData = body['data']['data'];

        List<Map<String, dynamic>> result = bodyData.map((item) {
          return {
            "name": item["name"] as String,
          };
        }).toList();

        Set<Map<String, dynamic>> uniqueResult = Set.from(result);

        return uniqueResult.toList();
      } else {
        // CustomeSnackBar.showErrorSnackBar(
        //     context: Get.context, title: 'Error', message: 'No data');
        return [];
      }
    } catch (e) {
      print(e);
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Error', message: e.toString());
      return [];
    }
  }
}
