import 'dart:convert';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/StoreController/cart_controller.dart';
import 'package:pbl6_app/src/controller/UserController/ship_info_cart.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
import '../../screens/homeScreen/order_success.dart';
import '../StoreController/store_detail_controller.dart';
import '../UserController/user_controller.dart';
import 'package:http/http.dart' as http;

class PlaceOrderController extends GetxController {
  final ShippingFeeController shippingFeeController;
  final CartController cartController;
  PlaceOrderController({
    required this.shippingFeeController,
    required this.cartController,
  });

  bool _isVNPayOption = false;
  bool get isVNPayOption => _isVNPayOption;

  getCart() {
    var cart = cartController.products.values.toList();
    var listCart = [];
    for (var item in cart) {
      var jsonItem = {
        "quantity": item.quantity,
        "price": item.price,
        "product": item.id,
        "notes": item.notes ?? ''
      };
      listCart.add(jsonItem);
    }
    return listCart;
  }

  Future<dynamic> placeOrderWithVNPay() async {
    var body = {
      "cart": getCart(),
      "coordinates":
          shippingFeeController.currentInfo.contact!.location!.coordinates,
      "totalPrice": cartController.productTotal(),
      "shipCost": shippingFeeController.currentInfo.shipCost
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<UserController>().token.value.toString()}',
    };

    var url =
        "${ApiEndPoints.baseUrl}/order/user/${Get.find<UserController>().id.value}/store/${Get.find<StoreDetailController>().storeId}";

    try {
      var jsonBody = jsonEncode(body);
      var response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var data = json['data'];
        var urlNew = json['url'].toString();
        print(urlNew);
        return urlNew;
      } else {
        print("Errror");
      }
      return '';
    } catch (e) {
      print("error $e");
      return '';
    }
  }

  void onPayment(String paymentUrl) async {
    var i = 0;
    // LoadingFullScreen.showLoading();
    try {
      if (paymentUrl != '') {
        VNPAYFlutter.instance.show(
          paymentUrl: paymentUrl,
          onPaymentSuccess: (params) async {
            print("Success>>>>>>>>>$params");
            await checkoutAfterPayment(params)
                .then((value) => Get.to(() => const OrderSuccess()));
          },
          onPaymentError: (params) {
            print("Not Success ${i++}");
            // Get.back();
          },
          onWebPaymentComplete: () {
            print("WebPayment Complete ${i++}");
          },
        );
      } else {
        CustomeSnackBar.showWarningTopBar(
            context: Get.context,
            title: 'Error',
            message: 'Thanh toán không thành công');
      }
    } catch (e) {}
  }

  Future checkoutAfterPayment(Map<String, dynamic> params) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<UserController>().token.value.toString()}',
    };
    var url = "${ApiEndPoints.baseUrl}/order/after-checkout/payment";

    try {
      print("checkout");
      Uri uri = Uri.parse(url).replace(queryParameters: params);
      var response = await http.get(uri, headers: headers);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = json['data'];
        print(data);
      } else {
        print("Errror");
      }
    } catch (e) {
      print("Error >> $e");
    }
  }

  changeOption(bool option) {
    _isVNPayOption = option;
    update();
  }
}
