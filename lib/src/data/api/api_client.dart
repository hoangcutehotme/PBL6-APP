import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  late String token;
  late Map<String, String> header;
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(milliseconds: 10);
    // token = '';
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
  // updateToken(String newToken) {
  //   token = newToken;
  // }

  Future<dynamic> getData(
    String url,
  ) async {
    var client = http.Client();
    try {
      http.Response response = await client.get(Uri.parse(url));
      return response;
    } catch (e) {
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
