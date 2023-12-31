import 'package:get/get.dart';
import 'package:pbl6_app/src/helper/func/func_useful.dart';
import '../../utils/api_endpoints.dart';
import '../api/api_client.dart';
import 'package:http/http.dart' as http;

class OrderRepo extends GetxService {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  getListOrderShipper(String id) async {
    var url = "${ApiEndPoints.baseUrl}/shipper/$id/find-orders";
    try {
      var response = await http.get(Uri.parse(url), headers: apiClient.header);
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
    // return await apiClient.getData(url);
  }

  getOrderDetail(String id) async {
    var url = "${ApiEndPoints.baseUrl}/order/$id";

    try {
      var response = await http.get(Uri.parse(url), headers: apiClient.header);
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
  }

  changeStatusShipper(String idOrder, String idShipper) async {
    var url = "${ApiEndPoints.baseUrl}/order/$idOrder/shipper/$idShipper";

    try {
      var response = await http.put(Uri.parse(url), headers: apiClient.header);
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
  }

  // getListOrderShipperInDay(DateTime date) async {

  //   try {
  //     var url = "${ApiEndPoints.baseUrl}/order/shipper/?start=${FuncUseful.stringDateTimeToDayMonthYear2(date)}";
  //     var response = await http.get(Uri.parse(url), headers: apiClient.header);
  //     return response;
  //   } catch (e) {
  //     return const Response(statusCode: 1);
  //   }
  //   // return await apiClient.getData(url);
  // }
}
