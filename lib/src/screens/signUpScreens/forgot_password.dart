import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/Authentication/forgot_password.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/rounded_button.dart';
import 'package:pbl6_app/src/widgets/text_field_widget.dart';

import 'verify_otp_forget_password.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgotPasswordController _forgetPassword =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            foregroundColor: AppColors.colorTextBold,
            backgroundColor: AppColors.mainColorBackground,
            shadowColor: Colors.transparent,
          ),
          // const SizedBox(height: 80),
          Container(
              padding: const EdgeInsets.only(left: 25),
              alignment: Alignment.center,
              child: Text(
                "Quên mật khẩu",
                style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
                textAlign: TextAlign.left,
              )),
          const SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.only(left: 27),
              alignment: Alignment.center,
              child: const Text(
                "Nhập emai của bạn, mã sẽ được gửi đến email của bạn",
                style: AppStyles.textMedium,
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 30),
          TextFieldContainer(
            child: TextField(
              controller: _forgetPassword.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.mail_outline_rounded,
                  color: AppColors.colorTextBlur,
                ),
                hintText: "Email",
                hintStyle: AppStyles.textMedium,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 29),
            alignment: Alignment.center,
            child: RoundedButton(
              press: () {
                _forgetPassword.forgotPasswordSendToEmail().then((value) {
                  if (value) {
                    Get.to(() => const VerifyOtpForgetPassword());
                  }
                });
              },
              text: 'Gửi',
              size: Size(size.width * 0.8, 56),
            ),
          ),
        ],
      ),
    ));
  }
}
