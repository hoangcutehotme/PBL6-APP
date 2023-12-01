import 'package:get/get.dart';
import '../../utils/api_endpoints.dart';
import '../api/api_client.dart';
import 'package:http/http.dart' as http;

class OrderRepo extends GetxService {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  getOrderDetailShipper(String id) async {
    var url = "${ApiEndPoints.baseUrl}/shipper/$id/find-orders";
    try {
      var response = await http.get(Uri.parse(url), headers: apiClient.header);
      return response;
    } catch (e) {
      return const Response(statusCode: 1);
    }
    // return await apiClient.getData(url);
  }
}
