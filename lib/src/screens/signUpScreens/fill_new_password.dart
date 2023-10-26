import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/Authentication/forgot_password.dart';

import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_field_widget.dart';

class FillNewPassword extends StatefulWidget {
  const FillNewPassword({super.key});

  @override
  State<FillNewPassword> createState() => _FillNewPasswordState();
}

class _FillNewPasswordState extends State<FillNewPassword> {
  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'Nhập mật khẩu mới',
            style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFieldContainer(
              child: TextField(
                controller: _forgotPasswordController.passwordController,
                obscureText: _forgotPasswordController.isShowPass.value,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black38,
                  ),
                  suffixIcon: IconButton(
                    splashColor: AppColors.mainColorBackground,
                    icon: Icon(
                      _forgotPasswordController.isShowPass.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      _forgotPasswordController.changeShowPass();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: "Mật khẩu",
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
                controller: _forgotPasswordController.passwordConfirmController,
                obscureText: _forgotPasswordController.isShowPassConfirm.value,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black38,
                  ),
                  suffixIcon: IconButton(
                    splashColor: AppColors.mainColorBackground,
                    icon: Icon(
                      _forgotPasswordController.isShowPassConfirm.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      _forgotPasswordController.changeShowPassConfirm();
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: "Xác nhận mật khẩu",
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
                _forgotPasswordController.resetPassword().then((value) {
                  if (value) {
                    Get.toNamed('/signin');
                  }
                });
              },
              text: 'Xác nhận',
              size: Size(size.width * 0.8, 56),
            ),
          ),
        ]),
      ),
    );
  }
}
