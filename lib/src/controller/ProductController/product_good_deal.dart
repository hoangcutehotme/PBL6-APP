import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';
import '../../utils/api_endpoints.dart';

class ProductGoodDeal extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  var client = http.Client();

  var list = <ProductModel>[].obs;

  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  @override
  void onInit() {
    super.onInit();
    fetchProductGoodDeal();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    list.value = [];
  }

  Future<void> fetchProductGoodDeal() async {
    isLoading(true);
    try {
      String name = 'Gà rán';
      var url = Uri.parse('${ApiEndPoints.baseUrl}/product?catName=$name');

      var response = await client.get(url);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = response.body;
        list.value = productsModelFromJson(jsonEncode(json['data']['data']));
        _productList = productsModelFromJson(jsonEncode(json['data']['data']));
        update();
      } else {
        CustomeSnackBar.showWarningTopBar(
            context: Get.context,
            title: 'Error product',
            message: 'Not Success');
      }
    } catch (e) {
      print(e.toString());
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Error product', message: 'Not Success');
    } finally {
      isLoading(false);
    }
  }
}
