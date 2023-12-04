import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/data/repository/order_repository.dart';
import 'package:pbl6_app/src/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/order_detail_shipper.dart';
import '../../utils/api_endpoints.dart';
import '../../values/app_string.dart';

class OrderController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final UserController userController;
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo, required this.userController});

  List<OrderModel> _listOrder = [];
  List<OrderModel> get listOrder => _listOrder;

  OrderDetailShipper _orderShipper = OrderDetailShipper();
  OrderDetailShipper get orderShipper => _orderShipper;

  var isLoading = false.obs;
  var client = http.Client();

  fetchListOrder(String status, String start, String end, int page) async {
    var prefs = await _prefs;

    var token = prefs.getString(AppString.SHAREPREF_TOKEN);
    var id = prefs.getString(AppString.SHAREPREF_USERID);

    var url = "${ApiEndPoints.baseUrl}/order/user/$id";

    try {
      Map<String, dynamic> params = {
        'status': status,
        'fields': 'status,dateOrdered,totalPrice',
        'sort': '-createdAt',
        'limit': '10',
        'page': page.toString(),
        'start': start,
        'end': end,
      };

      Uri uri = Uri.parse(url).replace(queryParameters: params);

      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(uri, headers: header);

      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _listOrder = orderModelFromJson(jsonEncode(json['data']));
        update();
        return _listOrder;
        // return listProduct;
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

  Future<OrderDetailShipper?> showOrderDetail(String id) async {
    try {
      var response = await orderRepo.getOrderDetailShipper(id);
      var jsonBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var order = OrderDetailShipper.fromJson(jsonBody['data']);
        _orderShipper = order;
        update();
        return order;
      } else {
        return OrderDetailShipper();
      }
    } catch (e) {
      return OrderDetailShipper();
    }
  }
  // Future<List<ProductModel>> getProductByStoreId(String? id) async {
  //   // isLoading(true);
  //   try {
  //     // ProductRepo productRepo = Get.put(ProductRepo());

  //     var url = "${ApiEndPoints.baseUrl}/product/store/$id?limit=10";

  //     var prefs = await _prefs;

  //     var token = prefs.getString(AppString.SHAREPREF_TOKEN);

  //     var header = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };

  //     var response = await http.get(Uri.parse(url), headers: header);
  //     // var response = await productRepo.getProductsByStoreId(id);
  //     var json = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       listProduct.value = [];
  //       listProduct.value =
  //           productsModelFromJson(jsonEncode(json['data']['data']));
  //       // _productList = productsModelFromJson(jsonEncode(json['data']['data']));
  //       update();
  //       return listProduct;
  //     } else {
  //       return [];
  //       // throw Exception(
  //       //     'Failed to get products. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error in getProductByStoreId: $e');
  //     return [];
  //     // Handle the error in a way that makes sense for your app
  //   } finally {
  //     // isLoading(false);
  //   }
  // }
}
