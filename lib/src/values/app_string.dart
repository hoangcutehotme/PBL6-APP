class AppString {
  static const String cart_pref = "CARTS";

  static Map<String, String> statusOrder = {
    "Pending": "Đang xử lý",
    "Waiting": "Đang chờ người giao hàng",
    "Preparing": "Đang chuẩn bị đơn hàng",
    "Delivering": "Đang trên đường giao hàng",
    "Finished": "Đã giao hàng thành công",
    "Refused": "Đơn hàng bị từ chối",
  };

  // sharepreference
  static const String SHAREPREF_USERID = "id_user";
  static const String SHAREPREF_TOKEN = "token";
  static const String ROLE = "role";

  // api key
  static const String API_KEY = "AIzaSyBZf311orMgVM261UAuLaGGkYVm8KvXjDY";
}
