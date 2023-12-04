import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/Authentication/register_controller.dart';
import 'package:pbl6_app/src/screens/signUpScreens/sign_in_screen.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/text_field_widget.dart';

import '../../widgets/rounded_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Obx(
          () => Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Text(
                "Đăng ký",
                style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
              ),
              const SizedBox(
                height: 20,
              ),
              _changeRoleSignUp(),
              const SizedBox(
                height: 10,
              ),
              logupForm(context, size, _registerController.isUser.value)
            ],
          ),
        ),
      )),
    );
  }

  Row _changeRoleSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
            text: "Người dùng",
            size: const Size(150, 30),
            background: _registerController.isUser.value
                ? AppColors.mainColor1
                : AppColors.borderGray,
            press: () {
              _registerController.changeRole("user");
            }),
        const SizedBox(
          width: 15,
        ),
        RoundedButton(
            text: "Giao hàng",
            background: _registerController.isUser.value
                ? AppColors.borderGray
                : AppColors.mainColor1,
            size: const Size(150, 30),
            press: () {
              _registerController.changeRole("shipper");
            })
      ],
    );
  }

  Column logupForm(BuildContext context, Size size, bool hide) {
    return Column(
      children: [
        
        TextFieldContainer(
          child: TextField(
            controller: _registerController.emailController,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.mail_outline_rounded,
                color: Colors.black38,
              ),
              hintText: "Email",
              hintStyle:
                  AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: _registerController.phoneController,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.phone,
                color: Colors.black38,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: "Số điện thoại",
              hintStyle:
                  AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
              border: InputBorder.none,
            ),
          ),
        ),
        Obx(
          () => TextFieldContainer(
            child: TextField(
              controller: _registerController.passwordController,
              obscureText: _registerController.isShowPass.value,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.black38,
                ),
                suffixIcon: IconButton(
                  splashColor: AppColors.mainColorBackground,
                  icon: Icon(
                    _registerController.isShowPass.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    _registerController.changeShowPass();
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
              controller: _registerController.passwordConfirmController,
              obscureText: _registerController.isShowPassConfirm.value,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.black38,
                ),
                suffixIcon: IconButton(
                  splashColor: AppColors.mainColorBackground,
                  icon: Icon(
                    _registerController.isShowPassConfirm.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    _registerController.changeShowPassConfirm();
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
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(top: 29),
          alignment: Alignment.center,
          child: RoundedButton(
            press: () {
              if (_registerController.isUser.value) {
                _registerController.validateForm()
                    ? Get.toNamed('/fillinfo')
                    : null;
              } else {
                _registerController.validateForm()
                    ? Get.toNamed('/fillinfo')
                    : null;
              }
            },
            text: 'Đăng ký',
            size: Size(size.width * 0.8, 56),
          ),
        ),
        Visibility(
          visible: hide,
          child: TextButton(
            onPressed: () {
              Get.offAllNamed("/home");
            },
            child: Text(
              "Bỏ qua",
              style: AppStyles.textBold
                  .copyWith(fontSize: 16, color: AppColors.mainColor1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Đã có tài khoản? ",
              style: AppStyles.textMedium,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignInScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "Đăng nhập",
                  style: AppStyles.textBold
                      .copyWith(color: AppColors.mainColor1, fontSize: 16),
                )),
          ],
        ),
      ],
    );
  }
}
