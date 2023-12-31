import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_string.dart';

class FuncUseful {
  static String formatStatus(String? status) {
    Map<String, Status> statusMap = AppString.statusOrder;

    return statusMap.containsKey(status)
        ? statusMap[status]!.description
        : "Đang xử lý";
  }

  static String formartStringPrice(int? price) {
    String formattedPrice = NumberFormat('#,##0', 'vi_VN').format(price);
    return formattedPrice;
  }

  static String stringDateTimeToDayMonthYear(DateTime? date) {
    return date == null ? '' : '${date.day}/${date.month}/${date.year}';
  }

  static String stringDateTimeToDayMonthYear2(DateTime date) {
    return DateFormat('d-MM-yyyy').format(date);
  }

  static String stringDateTimeToTime(DateTime date) {
    return DateFormat.Hms().format(date);
  }

  static String stringDateTimeToDay(DateTime dateTime) {
    return DateFormat('yyyy-MM-d').format(dateTime);
  }

  static String stringDateTimeToDayMonth(DateTime dateTime) {
    return DateFormat('d/MM').format(dateTime);
  }

  static String stringDateTimeToDayAndTime(DateTime? dateTime) {
    return dateTime != null
        ? "${DateFormat('d/MM/yyyy').format(dateTime)} ${DateFormat.Hms().format(dateTime)}"
        : '';
  }

  static Color colorStatus(String? status) {
    Map<String, Status> statusMap = AppString.statusOrder;
    return statusMap.containsKey(status)
        ? statusMap[status]!.color
        : AppColors.black;
  }
}
