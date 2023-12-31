import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  late String token;
  late Map<String, String> header;
  final SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    // timeout = const Duration(seconds: 10);
    token = sharedPreferences.getString(AppString.SHAREPREF_TOKEN) ?? '';
    header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  updateHeader(String token) {
    header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  saveToken(String newToken) {
    token = newToken;
  }

  getData(String uri) async {
    try {
      // final respone = await get(uri, headers: header);
      http.Response response = await http.get(Uri.parse(uri), headers: header);
      return response;
    } catch (e) {
      print("Error getData>>>>>>>>>> $e");
      return Future<Response>.value(
          Response(statusCode: 1, statusText: e.toString()));
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: header);
      return response;
    } catch (e) {
      print("Error getData>>>>>>>>>> $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body) async {
    try {
      Response response = await put(uri, body, headers: header);
      return response;
    } catch (e) {
      print(e);
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<dynamic> patchData(String url, dynamic body) async {
    var client = http.Client();
    try {
      http.Response response =
          await client.patch(Uri.parse(url), headers: header);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
