import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';

import '../../utils/custome_dialog.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';

class ChangeUserInfo extends StatefulWidget {
  const ChangeUserInfo({super.key});

  @override
  State<ChangeUserInfo> createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  // UserController userController = Get.put(UserController());
  // var user;

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
              if (Get.find<UserController>().checkChangeForm()) {
                CustomeDialog.showCustomeDialog(
                    context: Get.context,
                    title: 'Thông báo',
                    message: 'Bạn chưa lưu, Bạn có muốn thoát mà không lưu',
                    pressConfirm: () {
                      Get.find<UserController>().setInitInfo();
                      // Get.close(2);
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
                // Get.find<UserController>().changeEdit();
                // user = userController.user.value;
              },
              icon: Obx(
                () => Icon(
                  Icons.edit,
                  color: Get.find<UserController>().isEdit.value
                      ? AppColors.mainColor1
                      : AppColors.grayBold,
                ),
              ))
        ],
      ),
      body: changeInfoSection(context),
    );
  }

  GetBuilder<UserController> changeInfoSection(BuildContext context) {
    UserController userController = Get.find();
    return GetBuilder<UserController>(
        // initState: (state) => userController.setInitInfo(),
        builder: (_) {
      return SingleChildScrollView(
        child: Form(
          key: userController.changeInfoKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email '),
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  controller: userController.emailController,
                ),
                TextFormField(
                  key: const Key('lastname'),
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
                  key: const Key('firstname'),
                  readOnly: userController.isEdit.value,
                  decoration: const InputDecoration(labelText: 'Tên '),
                  keyboardType: TextInputType.name,
                  controller: userController.firstNameController,
                  onSaved: (value) {
                    userController.firstNameController.text = value!;

                  },
                  onChanged: (value) {
                    userController.isChange.value = true;
                  },
                  validator: (value) {
                    return userController.validateName(value!);
                  },
                ),
                TextFormField(
                  key: const Key('phone'),
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
                  key: const Key('address'),
                  decoration: const InputDecoration(labelText: 'Địa chỉ '),
                  keyboardType: TextInputType.emailAddress,
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
                Obx(
                  () => ElevatedButton(
                    key: const Key('saveButton'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: userController.isChange.value
                            ? AppColors.mainColor1
                            : AppColors.borderGray,
                        padding: const EdgeInsets.only(right: 30, left: 30)),
                    onPressed: userController.isChange.value
                        ? () {
                            if (userController.validateForm()) {
                              CustomeDialog.showCustomeDialog(
                                context: Get.context,
                                title: 'Thông báo',
                                message:
                                    'Bạn có chắc cập nhật thông tin mới ??',
                                pressConfirm: () async {
                                  await userController
                                      .updateUser(userController.id.value);
                                },
                                confirmText: 'Ok',
                              );
                            } 
                            // else {
                            //   CustomeSnackBar.showErrorSnackBar(
                            //       context: Get.context,
                            //       title: 'Error',
                            //       message: 'Thông tin nhập không hợp lệ');
                            // }
                          }
                        : null,
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
          // ),
        ),
      );
    });
  }
}
