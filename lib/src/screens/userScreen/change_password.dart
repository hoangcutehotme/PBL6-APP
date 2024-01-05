import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/UserController/user_change_password.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_field_widget.dart';

class ChangePasswordUser extends StatelessWidget {
  const ChangePasswordUser({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserChangePasswordController changePassController =
        Get.put(UserChangePasswordController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            foregroundColor: AppColors.colorTextBold,
            backgroundColor: AppColors.mainColorBackground,
            shadowColor: Colors.transparent,
          ),
          Container(
              padding: const EdgeInsets.only(left: 25),
              alignment: Alignment.center,
              child: Text(
                "Thay đổi mật khẩu",
                style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
                textAlign: TextAlign.left,
              )),
          const SizedBox(
            height: 40,
          ),
          Obx(
            () => TextFieldContainer(
              child: TextField(
                key: const Key('oldPassword'),
                controller: changePassController.oldPassController,
                obscureText: changePassController.showOldPassword.value,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black38,
                  ),
                  suffixIcon: IconButton(
                    splashColor: AppColors.mainColorBackground,
                    icon: Icon(
                      changePassController.showOldPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      changePassController.toggleShowOldPassword();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: "Mật khẩu hiện tại",
                  hintStyle: AppStyles.textMedium
                      .copyWith(color: AppColors.colorTextBlur),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Obx(
            () => TextFieldContainer(
              child: TextField(
                key: const Key('newPassword'),
                controller: changePassController.newPassController,
                obscureText: changePassController.showNewPassword.value,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black38,
                  ),
                  suffixIcon: IconButton(
                    splashColor: AppColors.mainColorBackground,
                    icon: Icon(
                      changePassController.showNewPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      changePassController.toggleShowNewPassword();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: "Mật khẩu mới",
                  hintStyle: AppStyles.textMedium
                      .copyWith(color: AppColors.colorTextBlur),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Obx(
            () => TextFieldContainer(
              child: TextField(
                key: const Key('confirmPassword'),
                controller: changePassController.confirmNewPassController,
                obscureText: changePassController.showConfirmPassword.value,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black38,
                  ),
                  suffixIcon: IconButton(
                    splashColor: AppColors.mainColorBackground,
                    icon: Icon(
                      changePassController.showConfirmPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      changePassController.toggleShowConfirmPassword();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: "Nhập lại mật khẩu mới ",
                  hintStyle: AppStyles.textMedium
                      .copyWith(color: AppColors.colorTextBlur),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 29),
            alignment: Alignment.center,
            child: RoundedButton(
              press: () {
                if (changePassController.checkData()) {
                  changePassController.resetPassword();
                }
              },
              text: 'Xác nhận',
              size: Size(size.width * 0.8, 56),
            ),
          ),
        ],
      ),
    ));
  }
}
