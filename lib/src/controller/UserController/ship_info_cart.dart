import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
// import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/model/info_cart_model.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';

class ShippingFeeController extends GetxController {
  List<InfoCart> _contact = [];
  List<InfoCart> get contact => _contact;

  InfoCart _currentInfo = InfoCart();
  InfoCart get currentInfo => _currentInfo;

  DateTime get timeExpectedDelivery {
    DateTime timeNow = DateTime.now();
    int timeDelivery = _currentInfo.deliveryTime ?? 30;
    DateTime timeExpectedDelivery =
        timeNow.add(Duration(minutes: timeDelivery));
    return timeExpectedDelivery;
  }

  getInfoShip(String userId, String storeId) async {
    try {
      var url = "${ApiEndPoints.baseUrl}/user/$userId/store/$storeId";

      ApiClient apiClient = Get.find();
      var headers = apiClient.header;

      var response = await http.get(Uri.parse(url), headers: headers);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _contact = infoCartFromJson(jsonEncode(json['data']));
        await getCurrentContact();
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  getCurrentContact() {
    _currentInfo = _contact.firstWhere((element) =>
        element.contact?.id == Get.find<UserController>().contacChoose.id);
    update();
    return currentInfo;
  }

  // getNowDelivery() {
  //   DateTime timeNow = DateTime.now();
  //   int timeDelivery = _currentInfo.deliveryTime ?? 30;
  //   DateTime timeExpectedDelivery =
  //       timeNow.add(Duration(minutes: timeDelivery));

  //   String timeExpectedString =
  //       '${FuncUseful.stringDateTimeToTime(timeExpectedDelivery)} - ${FuncUseful.stringDateTimeToDayMonthYear(timeExpectedDelivery)}';

  //   return timeExpectedString;
  // }
}
