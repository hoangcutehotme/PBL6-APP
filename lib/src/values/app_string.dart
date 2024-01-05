import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

class Status {
  final String description;
  final Color color;

  Status(this.description, this.color);
}

class AppString {
  static const String cart_pref = "CARTS";

  static Map<String, Status> statusOrder = {
    "Pending": Status("Đang xử lý", AppColors.colorStatusNormal),
    "Waiting": Status("Đang chờ người giao hàng", AppColors.colorStatusNormal),
    "Preparing": Status("Đang chuẩn bị đơn hàng", AppColors.colorStatusNormal),
    "Delivering":
        Status("Đang trên đường giao hàng", AppColors.colorStatusNormal),
    "Finished": Status("Đã giao hàng thành công", AppColors.colorSuccess),
    "Refused": Status("Đơn hàng bị từ chối", AppColors.mainColor1),
  };

  // sharepreference
  static const String SHAREPREF_USERID = "id_user";
  static const String SHAREPREF_TOKEN = "token";
  static const String ROLE = "role";

  // api key AIzaSyB1HeHIghTdPtji7wT84i_FOAupZRwVBlY AIzaSyDxvSKzQyy-I3D5Lhr44rVJh2VXm1FXwYY
  static const String API_KEY = "AIzaSyC6j6rRG_746mqp91Bjovr8yyD5GXhrXec";

  // marker

  static const String markerShipper = "markerShipper";
  static const String markerCustomer = "markerCustomer";
  static const String markerStore = "markerStore";
}
