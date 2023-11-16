import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';
import '../../model/store_model.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/custome_snackbar.dart';
import '../../values/app_string.dart';

class StoreDetailController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  var client = http.Client();

  StoreModel _store = StoreModel();
  StoreModel get store => _store;

  var listProduct = <ProductModel>[].obs;

  var storeId = ''.obs;

  @override
  void onReady() {}

  updateStore(String id) {
    storeId.value = id;
    getStoreFromId(id);
    getProductByStoreId(id);
  }

  Future<StoreModel> getStoreFromId(String? id) async {
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}/store/$id');

      var response = await client.get(url);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _store = StoreModel();
        _store = StoreModel.fromJson(json['data']);
        update();
        return _store;
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context, title: 'Error', message: json['message']);

        // return StoreModel.fromJson(storeJson);
        return StoreModel();
        // return null;
      }
    } catch (e) {
      // CustomeSnackBar.showErrorSnackBar(
      //     context: Get.context, title: 'Error sys', message: e.toString());
      // return StoreModel.fromJson(storeJson);
      return StoreModel();
    } finally {
      // isLoading(false);
      // LoadingFullScreen.cancelLoading();
    }
  }

  Future<List<ProductModel>> getProductByStoreId(String? id) async {
    // isLoading(true);
    try {
      // ProductRepo productRepo = Get.put(ProductRepo());

      var url = "${ApiEndPoints.baseUrl}/product/store/$id?limit=10";

      var prefs = await _prefs;

      var token = prefs.getString(AppString.SHAREPREF_TOKEN);

      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(Uri.parse(url), headers: header);
      // var response = await productRepo.getProductsByStoreId(id);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        listProduct.value = [];
        listProduct.value =
            productsModelFromJson(jsonEncode(json['data']['data']));
        // _productList = productsModelFromJson(jsonEncode(json['data']['data']));
        update();
        return listProduct;
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
      // isLoading(false);
    }
  }
}
