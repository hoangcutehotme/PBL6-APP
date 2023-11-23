import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/food_category_model.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {
  var listCategory = <CategoryModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller is initialized
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchCategories();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    listCategory.value = [];
  }

  void fetchCategories() async {
    isLoading(true);
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}/category');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        var data = response.body;
        listCategory.value = categoryModelFromJson(data);

        update();
        // Assign data to the observable list
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Text("Error Category"),
                children: [Text("Not success")],
              );
            });
      }
    } catch (e) {
      // Handle any errors that occurred during the API call
      print(e.toString());
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error Category"),
              children: [Text(e.toString())],
            );
          });
    } finally {
      isLoading(false);
    }
  }
}
