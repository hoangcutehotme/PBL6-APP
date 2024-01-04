import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';

import '../../../utils/custome_dialog.dart';
import '../../../values/app_assets.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_styles.dart';
import '../../../widgets/image_loading_network.dart';

class ChangeShipperInfo extends StatelessWidget {
  const ChangeShipperInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.mainColor1,
        backgroundColor: AppColors.mainColorBackground,
        title: Text(
          "Thay đổi thông tin cá nhân",
          style: AppStyles.textBold.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              if (Get.find<ShipperController>().checkChangeForm()) {
                CustomeDialog.showCustomeDialog(
                    context: Get.context,
                    title: 'Thông báo',
                    message: 'Bạn chưa lưu, Bạn có muốn thoát mà không lưu',
                    pressConfirm: () {
                      Get.find<ShipperController>().setInitInfo();
                    },
                    confirmText: 'Ok');
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                // Get.find<ShipperController>().changeEdit();
                // user = userController.user.value;
              },
              icon: Obx(
                () => Icon(
                  Icons.edit,
                  color: Get.find<ShipperController>().isEdit.value
                      ? AppColors.mainColor1
                      : AppColors.grayBold,
                ),
              ))
        ],
      ),
      body: changeInfoSection(context),
    );
  }

  GetBuilder<ShipperController> changeInfoSection(BuildContext context) {
    ShipperController userController = Get.find();
    return GetBuilder<ShipperController>(builder: (_) {
      return SingleChildScrollView(
        child: Form(
          key: userController.changeInfoKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                userController.user.value.photo == null
                    ? Image.asset(
                        AppAssets.getImg("user_avartar2.png", "images"),
                        width: 80,
                        height: 80,
                      )
                    : CircleAvatar(
                        radius: 30,
                        child: ImageLoadingNetwork(
                            image: userController.user.value.photo!,
                            size: const Size(80, 80)),
                      ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  controller: userController.emailController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    // labelText: 'Họ ',
                    label: Text('Họ'),
                  ),
                  readOnly: userController.isEdit.value,
                  keyboardType: TextInputType.name,
                  controller: userController.lastnameController,
                  onSaved: (value) {
                    userController.lastnameController.text = value!;
                  },
                  onChanged: (value) {
                    userController.isChange.value = true;
                  },
                  validator: (value) {
                    return userController.validateName(value!);
                  },
                ),
                TextFormField(
                  readOnly: userController.isEdit.value,
                  decoration: const InputDecoration(labelText: 'Tên '),
                  keyboardType: TextInputType.name,
                  controller: userController.firstNameController,
                  onSaved: (value) {
                    userController.firstNameController.text = value!;

                    print("Value : $value");
                  },
                  onChanged: (value) {
                    userController.isChange.value = true;
                  },
                  validator: (value) {
                    return userController.validateName(value!);
                  },
                ),
                TextFormField(
                  readOnly: userController.isEdit.value,
                  decoration:
                      const InputDecoration(labelText: 'Số điện thoại '),
                  keyboardType: TextInputType.phone,
                  controller: userController.phoneController,
                  onSaved: (value) {
                    userController.phoneController.text = value!;
                  },
                  onChanged: (value) {
                    userController.isChange.value = true;
                  },
                  validator: (value) {
                    return userController.validatePhone(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Địa chỉ '),
                  keyboardType: TextInputType.none,
                  // initialValue: user.email,
                  readOnly: userController.isEdit.value,
                  controller: userController.addressController,
                  onSaved: (value) {
                    userController.addressController.text = value!;
                  },
                  onChanged: (value) {
                    userController.isChange.value = true;
                  },
                  validator: (value) {
                    return userController.validateAddress(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Số xe '),
                  keyboardType: TextInputType.none,
                  readOnly: userController.isEdit.value,
                  controller: userController.vehicleNumber,
                  onSaved: (value) {
                    userController.vehicleNumber.text = value!;
                  },
                  onChanged: (value) {
                    userController.isChange.value = true;
                  },
                  validator: (value) {
                    return userController.validateAddress(value!);
                  },
                ),
                Obx(
                  ()=> TextFormField(
                    decoration: const InputDecoration(labelText: 'Loại xe '),
                    keyboardType: TextInputType.none,
                    // initialValue: user.email,
                    readOnly: userController.isEdit.value,
                    controller: userController.vehicleType,
                    onSaved: (value) {
                      userController.vehicleType.text = value!;
                    },
                    onChanged: (value) {
                      userController.isChange.value = true;
                    },
                    validator: (value) {
                      return userController.validateAddress(value!);
                    },
                  ),
                ),
                Obx(
                  ()=> TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Số giấy phép lái xe '),
                    keyboardType: TextInputType.number,
                    readOnly: userController.isEdit.value,
                    controller: userController.licenseNumber,
                    onSaved: (value) {
                      userController.licenseNumber.text = value!;
                    },
                    onChanged: (value) {
                      userController.isChange.value = true;
                    },
                    validator: (value) {
                      return userController.validateAddress(value!);
                    },
                  ),
                ),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: userController.isChange.value
                            ? AppColors.mainColor1
                            : AppColors.borderGray,
                        padding: const EdgeInsets.only(right: 30, left: 30)),
                    onPressed: () {
                      if (userController.validateForm()) {
                        CustomeDialog.showCustomeDialog(
                          context: Get.context,
                          title: 'Thông báo',
                          message: 'Bạn có chắc cập nhật thông tin mới ??',
                          pressConfirm: () async {
                            await userController
                                .updateUser(userController.id.value);
                          },
                          confirmText: 'Ok',
                        );
                      } else {
                        CustomeSnackBar.showErrorSnackBar(
                            context: Get.context,
                            title: 'Error',
                            message: 'Thông tin nhập không hợp lệ');
                      }
                    },
                    child: Text(
                      'Lưu',
                      style: AppStyles.textMedium
                          .copyWith(color: AppColors.mainColorBackground),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
