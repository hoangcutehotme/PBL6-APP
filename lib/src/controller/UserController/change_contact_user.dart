import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';

import 'package:pbl6_app/src/data/repository/user_respository.dart';

import '../../model/contact_model.dart';

class ChangeContact extends GetxController {
  final UserRespo userRespo;
  final UserController userController;
  ChangeContact({
    required this.userController,
    required this.userRespo,
  });

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  initValue(Contact contact) {
    phoneController.text = (contact.phoneNumber ?? '').toString();
    addressController.text = (contact.address ?? '').toString();
    update();
  }

  addNewContact() async {
    try {
      var body = {
        "address": addressController.text.trim(),
        "phoneNumber": phoneController.text.trim()
      };
      var controller = Get.find<UserController>();
      controller.addNewContact(body);

      // if (response.statusCode == 200) {

      //   CustomeSnackBar.showSuccessSnackTopBar(
      //       context: Get.context, title: 'Success', message: 'Thêm thành công');
      // } else {
      //   CustomeSnackBar.showWarningTopBar(
      //       context: Get.context,
      //       title: 'Error',
      //       message: 'Thêm không thành công');
      // }
    } catch (e) {
      print(e);
    }
  }
}
