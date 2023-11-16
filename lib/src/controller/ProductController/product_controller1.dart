import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_endpoints.dart';
import '../../values/app_string.dart';

import 'package:http/http.dart' as http;

class ProductController1 extends GetxController {
  List _productList = [];
  List get productList => _productList;
  var list = <ProductModel>[].obs;
  var isLoading = false.obs;

  Future<List<ProductModel>> getProductByStoreId(String id) async {
    isLoading(true);
    try {
      var url = "${ApiEndPoints.baseUrl}/product/store/$id?limit=10";

      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString(AppString.SHAREPREF_TOKEN);

      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(Uri.parse(url), headers: header);
      // var response = await productRepo.getProductsByStoreId(id);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _productList = [];
        list.value = productsModelFromJson(jsonEncode(json['data']['data']));
        // _productList = productsModelFromJson(jsonEncode(json['data']['data']));
        update();
        return list;
      } else {
        return [];
        // throw Exception(
        //     'Failed to get products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getProductByStoreId: $e');
      return [];
      // Handle the error in a way that makes sense for your app
    } finally {
      isLoading(false);
    }
  }
}
