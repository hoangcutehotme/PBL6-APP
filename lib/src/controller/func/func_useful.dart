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

  static String formatStatus(String? status) {
    Map<String, String> statusMap = AppString.statusOrder;

    return statusMap.containsKey(status) ? statusMap[status]! : "Đang xử lý";

  }

  static String formartStringPrice(int? price) {
    String formattedPrice = NumberFormat('#,##0', 'vi_VN').format(price);
    return formattedPrice;
  }

  static String stringDateTimeToDayMonthYear(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String stringDateTimeToTime(DateTime date) {
    return '${date.hour}:${date.minute}:${date.second}';
  }
  static String stringDateTimeToDay(DateTime dateTime) {
    return DateFormat('yyyy-MM-d').format(dateTime);
  }

  static String stringDateTimeToDayMonth(DateTime dateTime) {
    return DateFormat('d/MM').format(dateTime);
  }
  
}
