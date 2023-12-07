import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FuncUseful {
  static Future saveJson(String key, json) async {
    final prefs = await SharedPreferences.getInstance();
    var saveJson = jsonEncode(json);
    print(saveJson);
    await prefs.setString(key, saveJson);
  }

  static Future getDataJson(String key) async {
    final pref = await SharedPreferences.getInstance();
    var temp = pref.getString(key) ?? "nodata";
    // var data = UserModel.fromMap(jsonDecode(temp.toString()));
    var data = jsonDecode(temp.toString());

    return data;
  }

  static void showLoading(bool loading) {
    loading
        ? showDialog(
            context: Get.context!,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            })
        : Get.back();
  }

  static String formatStatus(String? status) {
    Map<String, String> statusMap = AppString.statusOrder;

    return statusMap.containsKey(status) ? statusMap[status]! : "Đang xử lý";
    // return status == "Pending"
    //     ? "Đang xử lý"
    //     : status == "Refused"
    //         ? "Từ chối đơn hàng"
    //         : status == "Preparing"
    //             ? "Đang chuẩn bị đơn hàng"
    //             : status == "Delivering"
    //                 ? "Đang trên đường giao hàng"
    //                 : status == "Finished"
    //                     ? "Đã giao hàng thành công"
    //                     : status == "Waiting"
    //                         ? "Đang chờ người giao hàng"
    //                         : "Đang xử lý";
  }

  static String formartStringPrice(int? price) {
    String formattedPrice = NumberFormat('#,##0', 'vi_VN').format(price);
    return formattedPrice;
  }
}
