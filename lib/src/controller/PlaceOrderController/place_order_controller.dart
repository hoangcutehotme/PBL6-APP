import 'dart:convert';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/StoreController/cart_controller.dart';
import 'package:pbl6_app/src/controller/StoreController/voucher_controller.dart';
import 'package:pbl6_app/src/controller/UserController/ship_info_cart.dart';
import 'package:pbl6_app/src/data/repository/voucher_repository.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
import '../../screens/homeScreen/order_success.dart';
import '../StoreController/store_detail_controller.dart';
import '../UserController/user_controller.dart';
import 'package:http/http.dart' as http;

class PlaceOrderController extends GetxController {
  final ShippingFeeController shippingFeeController;
  final CartController cartController;
  final VoucherRepo voucherRepo;
  final UserController userController;
  final VoucherController voucherController;

  PlaceOrderController({
    required this.shippingFeeController,
    required this.cartController,
    required this.voucherRepo,
    required this.userController,
    required this.voucherController,
  });

  bool _isVNPayOption = true;
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
      "contact": shippingFeeController.currentInfo.contact?.id,
      "totalPrice": (cartController.totalCart +
          shippingFeeController.currentInfo.shipCost!.toInt() -
          (voucherController.chooseVoucher.amount ?? 0)),
      "shipCost": shippingFeeController.currentInfo.shipCost
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<UserController>().token.value.toString()}',
    };

    var url =
        "${ApiEndPoints.baseUrl}/order/user/${Get.find<UserController>().id.value}/store/${Get.find<StoreDetailController>().storeId}";
    LoadingFullScreen.showLoading();
    try {
      var jsonBody = jsonEncode(body);
      var response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var urlNew = json['url'].toString();
        var orderId = json['data']['_id'];
        if (orderId == null) {
          return [];
        } else {
          return [urlNew, orderId];
        }
      } else {
        print("Error");
      }
      return '';
    } catch (e) {
      print("error $e");
      return '';
    } finally {
      LoadingFullScreen.cancelLoading();
    }
  }

  onPayment(String paymentUrl, String orderId) async {
    var i = 0;
    try {
      if (paymentUrl != '') {
        VNPAYFlutter.instance.show(
          paymentUrl: paymentUrl,
          onPaymentSuccess: (params) async {
            await checkoutAfterPayment(params);
            if (voucherController.chooseVoucher.id != null) {
              print(i++);
              await voucherRepo.useVoucher(
                  voucherController.chooseVoucher.id!, orderId);
            }

            await Get.offAll(() => const OrderSuccess(),arguments: orderId);
          },
          onPaymentError: (params) {
            CustomeSnackBar.showMessageTopBar(
                context: Get.context,
                title: 'Thông báo',
                message: 'Thanh toán không thành công');
          },
          onWebPaymentComplete: () {},
        );
      } else {
        CustomeSnackBar.showWarningTopBar(
            context: Get.context,
            title: 'Error',
            message: 'Thanh toán không thành công');
      }
    } catch (e) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Thanh toán không thành công');
    }
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
        return true;
      } else {
        print("Errror");
      }
    } catch (e) {
      print("Error >> $e");
      throw Exception(e);
    }
  }

  changeOption(bool option) {
    _isVNPayOption = option;
    update();
  }
}
