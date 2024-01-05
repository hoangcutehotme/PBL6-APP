import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/model/voucher_model.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class VoucherRepo extends GetxService {
  getListVoucherByIdStore(String storeID) async {
    try {
      var url = '${ApiEndPoints.baseUrl}/voucher/store/$storeID';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        List<Voucher> listVoucher = voucherFromJson(jsonEncode(body['data']));

        return listVoucher;
      } else {
        return <Voucher>[];
      }
    } catch (e) {
      print(e);
    }
  }

  useVoucher(String voucherId, String orderId) async {
    try {
      ApiClient apiClient = Get.find();
      var headers = apiClient.header;
      var url = '${ApiEndPoints.baseUrl}/voucher/$voucherId/order/$orderId';

      var response = await http.put(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print("Use voucher");
        var body = jsonDecode(response.body);
        print(body);
      } else {
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }
}
