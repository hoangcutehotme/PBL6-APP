import 'package:get/get.dart';

import 'package:pbl6_app/src/data/repository/voucher_repository.dart';
import 'package:pbl6_app/src/model/voucher_model.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';

class VoucherController extends GetxController {
  VoucherRepo voucherRepo;

  VoucherController({
    required this.voucherRepo,
  });

  List<Voucher> _listVoucher = [];
  List<Voucher> get listVoucher => _listVoucher;

  Voucher _chooseVoucher = Voucher();
  Voucher get chooseVoucher => _chooseVoucher;

  getListVoucherByStoreId(String id) async {
    try {
      var listvoucher = await voucherRepo.getListVoucherByIdStore(id);
      _listVoucher = listvoucher;
      update();
    } catch (e) {
      print(e);
    }
  }

  getVoucher(Voucher voucher, String userId, int totalOrder) {
    if (!checkValidVoucher(voucher, userId)) {
      CustomeSnackBar.showMessageTopBar(
          context: Get.context,
          title: "Thông báo",
          message: "Voucher này đã được dùng hoặc hết hạn");
      return false;
    } else if (totalOrder < voucher.conditions!.minValues!.toInt()) {
      CustomeSnackBar.showMessageTopBar(
          context: Get.context,
          title: "Thông báo",
          message: "Bạn chưa đủ điều kiện để chọn voucher này");
      return false;
    } else {
      _chooseVoucher = voucher;
      update();
      return true;
    }
  }

  checkValidVoucher(Voucher voucher, String userID) {
    // check voucher have been used and the day end
    return !voucher.user!.any((element) => element.userId == userID) &&
        voucher.conditions!.endDate!.isAfter(DateTime.now());
  }

  bool checkVoucher(Voucher voucher, String userId, int totalOrder) {
    if (!checkValidVoucher(voucher, userId)) {
      return false;
    } else if (totalOrder < voucher.conditions!.minValues!.toInt()) {
      return false;
    } else {
      return true;
    }
  }
}
