import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_endpoints.dart';
import '../api/api_client.dart';
import 'package:http/http.dart' as http;

class OrderStatisticRepo extends GetxService {
  final ApiClient apiClient;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  OrderStatisticRepo(
      {required this.apiClient});

  Future getStatisticDaily() async {
    final SharedPreferences prefs = await _prefs;
    var idShipper = prefs.getString(AppString.SHAREPREF_USERID);
    var url = "${ApiEndPoints.baseUrl}/shipper/$idShipper/daily";
    try {
      var response = await http.get(Uri.parse(url), headers: apiClient.header);
      print("response shipper : $response");
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
  }

  Future getStatisticWeek() async {
    final SharedPreferences prefs = await _prefs;
    var idShipper = prefs.getString(AppString.SHAREPREF_USERID);
    var url = "${ApiEndPoints.baseUrl}/shipper/$idShipper/weekly";
    try {
      var response = await http.get(Uri.parse(url), headers: apiClient.header);
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
  }

  Future getStatisticMonth() async {
    final SharedPreferences prefs = await _prefs;
    var idShipper = prefs.getString(AppString.SHAREPREF_USERID);
    var url = "${ApiEndPoints.baseUrl}/shipper/$idShipper/monthly";
    try {
      var response = await http.get(Uri.parse(url), headers: apiClient.header);
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
    // return await apiClient.getData(url);
  }

  getOrderDetailShipper(String id) async {
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
}
