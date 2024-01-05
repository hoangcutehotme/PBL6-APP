import 'dart:io';

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
                      Get.back();
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
                // user = shipperController.user.value;
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
    ShipperController shipperController = Get.find();
    return GetBuilder<ShipperController>(
        initState: (state) => shipperController.getInfoShipperrById(),
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: shipperController.changeInfoKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GetBuilder<ShipperController>(builder: (_) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          shipperController.getImage();
                        },
                        child: shipperController.user.value.photo == null
                            ? Image.asset(
                                AppAssets.getImg("user_avartar2.png", "images"),
                                width: 100,
                                height: 100,
                              )
                            : shipperController.photo != null
                                ? Image.file(
                                    File(shipperController.photo!.path),
                                    width: 100,
                                    height: 100,
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.placeholder,
                                    child: ImageLoadingNetwork(
                                        image:
                                            shipperController.user.value.photo!,
                                        size: const Size(80, 80)),
                                  ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        controller: shipperController.emailController,
                      ),
                      Obx(
                        () => TextFormField(
                          decoration: const InputDecoration(
                            // labelText: 'Họ ',
                            label: Text('Họ'),
                          ),
                          readOnly: shipperController.isEdit.value,
                          keyboardType: TextInputType.name,
                          controller: shipperController.lastnameController,
                          onSaved: (value) {
                            shipperController.lastnameController.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validateName(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          readOnly: shipperController.isEdit.value,
                          decoration: const InputDecoration(labelText: 'Tên '),
                          keyboardType: TextInputType.name,
                          controller: shipperController.firstNameController,
                          onSaved: (value) {
                            shipperController.firstNameController.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validateName(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          readOnly: shipperController.isEdit.value,
                          decoration: const InputDecoration(
                              labelText: 'Số điện thoại '),
                          keyboardType: TextInputType.phone,
                          controller: shipperController.phoneController,
                          onSaved: (value) {
                            shipperController.phoneController.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validatePhone(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Địa chỉ '),
                          keyboardType: TextInputType.none,
                          // initialValue: user.email,
                          readOnly: shipperController.isEdit.value,
                          controller: shipperController.addressController,
                          onSaved: (value) {
                            shipperController.addressController.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validateAddress(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Số xe '),
                          keyboardType: TextInputType.none,
                          readOnly: shipperController.isEdit.value,
                          controller: shipperController.vehicleNumber,
                          onSaved: (value) {
                            shipperController.vehicleNumber.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validate(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Loại xe '),
                          keyboardType: TextInputType.none,
                          // initialValue: user.email,
                          readOnly: shipperController.isEdit.value,
                          controller: shipperController.vehicleType,
                          onSaved: (value) {
                            shipperController.vehicleType.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validate(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Số giấy phép lái xe '),
                          keyboardType: TextInputType.number,
                          readOnly: shipperController.isEdit.value,
                          controller: shipperController.licenseNumber,
                          onSaved: (value) {
                            shipperController.licenseNumber.text = value!;
                          },
                          onChanged: (value) {
                            shipperController.isChange.value = true;
                          },
                          validator: (value) {
                            return shipperController.validate(value!);
                          },
                        ),
                      ),
                      Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: shipperController.isChange.value
                                  ? AppColors.mainColor1
                                  : AppColors.borderGray,
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30)),
                          onPressed: () {
                            if (shipperController.validateForm()) {
                              CustomeDialog.showCustomeDialog(
                                context: Get.context,
                                title: 'Thông báo',
                                message:
                                    'Bạn có chắc cập nhật thông tin mới ??',
                                pressConfirm: () async {
                                  shipperController
                                      .updateUser(shipperController.id.value);
                                },
                                confirmText: 'Ok',
                              );
                            } else {
                              CustomeSnackBar.showWarningTopBar(
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
                  );
                }),
              ),
            ),
          );
        });
  }
}
