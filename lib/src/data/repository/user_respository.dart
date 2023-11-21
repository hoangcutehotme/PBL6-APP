import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';

class UserRespo extends GetxService {
  final ApiClient apiClient;

  UserRespo({required this.apiClient});

  getUserInfo(String userId) async {
    var url = "${ApiEndPoints.baseUrl}/user/$userId";
    return await apiClient.getData(url);
  }

  Future<Response> addAddressContact(String userId, dynamic body) async {
    print("REPO");
    var url = "${ApiEndPoints.baseUrl}/user/add-contact/$userId";
    return await apiClient.putData(url, jsonEncode(body));
  }
}
