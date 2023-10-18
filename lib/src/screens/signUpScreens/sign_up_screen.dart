import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
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
  String? selectedValue;

  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool showSkip = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Đăng ký",
                style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                      text: "Người dùng",
                      size: const Size(150, 30),
                      press: () {
                        setState(() {
                          showSkip = true;
                        });
                      }),
                  const SizedBox(
                    width: 15,
                  ),
                  RoundedButton(
                      text: "Giao hàng",
                      background: AppColors.borderGray,
                      size: const Size(150, 30),
                      press: () {
                        setState(() {
                          showSkip = false;
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              logupForm(context, size, showSkip)
            ],
          ),
        ),
      ),
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
        TextFieldContainer(
          child: TextField(
            controller: _registerController.passwordController,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.black38,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: "Mật khẩu",
              hintStyle:
                  AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: _registerController.passwordConfirmController,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.black38,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: "Xác nhận mật khẩu",
              hintStyle:
                  AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
              border: InputBorder.none,
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
              Get.toNamed("/fillinfo");
            },
            text: 'Đăng ký',
            size: Size(size.width * 0.8, 56),
          ),
        ),
        Visibility(
          visible: hide,
          child: TextButton(
            onPressed: () {
              Get.toNamed("/home");
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

  TextFieldContainer selectWiget(List<String> roles) {
    return TextFieldContainer(
        child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
          hintText: 'Select Role',
          hintStyle:
              AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
          border: InputBorder.none),
      alignment: Alignment.center,
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: roles.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
  }
}
