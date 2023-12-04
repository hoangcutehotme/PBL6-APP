import 'package:get/get.dart';

import '../../utils/api_endpoints.dart';
import '../api/api_client.dart';

class ShipperRepo extends GetxService {
  final ApiClient apiClient;

  ShipperRepo({required this.apiClient});

  getUserInfo(String userId) async {
    var url = "${ApiEndPoints.baseUrl}/user/$userId";
    return await apiClient.getData(url);
  }

  Future<Response> getListOrderNearShipper(String id) async {
    var url = "${ApiEndPoints.baseUrl}/shipper/$id/find-orders";
    return await apiClient.getData(url);
  }

  
}
