import 'dart:convert';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product_model.dart';

class StoreController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  var listStore = <StoreModel>[].obs;

  var client = http.Client();

  // StoreModel _store = StoreModel();
  // StoreModel get store => _store;

  var listProduct = <ProductModel>[].obs;

  var storeId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStores();
  }

  @override
  void onReady() {
    fetchStores();
  }

  Future<void> fetchStores() async {
    isLoading(true);
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}/store?isLocked=false');

      var response = await http.get(url);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        listStore.value = storeModelFromJson(jsonEncode(json['data']));
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context, title: 'Error', message: json['message']);
      }
    } catch (e) {
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Error', message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  var storeJson = {
    "location": {
      "coordinates": [16.05636, 108.17055],
      "type": "Point"
    },
    "ratingAverage": 0,
    "rating": [],
    "isLocked": false,
    "_id": "654c2d531bcf4800076d5db8",
    "phoneNumber": "0776230217",
    "address": "Đội 1  - An thuỷ - Lệ Thuỷ - Quảng Bình",
    "name": "Jollibee - EC Ngô Quyền",
    "openAt": "9:00",
    "closeAt": "21:00",
    "description": "Giao diện xấu",
    "registrationLicense": "12312",
    "ownerId": "654c2d521bcf4800076d5db3",
    "image":
        "https://res.cloudinary.com/drk3oaeza/image/upload/v1699491152/pbl6/wfo50jk5ythz7uzkdkaj.jpg",
    "createdAt": "2023-11-09T00:52:35.234Z",
    "updatedAt": "2023-11-09T08:43:45.611Z"
  };
}
