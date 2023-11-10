import 'dart:convert';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/store_model.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/custome_snackbar.dart';

class StoreController extends GetxController {
  var isLoading = false.obs;

  var listStore = <StoreModel>[].obs;
  var client = http.Client();

  @override
  void onInit() {
    super.onInit();
    fetchStores();
  }

  @override
  void onReady() {
    fetchStores();
  }

  Future<StoreModel?> getStoreFromId(String? id) async {
    // isLoading(true);
    // LoadingFullScreen.showLoading();
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}/store/$id');

      var response = await client.get(url);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var store = StoreModel.fromJson(json['data']);

        return store;
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context, title: 'Error', message: json['message']);
        return null;
      }
    } catch (e) {
      // LoadingFullScreen.cancelLoading();
      print(e);
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Error', message: e.toString());
      return null;
    } finally {
      // isLoading(false);
      // LoadingFullScreen.cancelLoading();
    }
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
}
