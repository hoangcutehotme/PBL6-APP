import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepo extends GetxService {
  var client = http.Client();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<dynamic> getProductsByStoreId(String id) async {
    try {
      var url = "${ApiEndPoints.baseUrl}/product/store/$id?limit=10";

      SharedPreferences prefs = await _prefs;
      var token = prefs.getString(AppString.SHAREPREF_TOKEN);
      
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await client.get(Uri.parse(url), headers: header);
      return response;
    } catch (e) {
      print(e);
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
