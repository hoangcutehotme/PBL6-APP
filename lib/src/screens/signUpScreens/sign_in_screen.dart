import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/Authentication/login_controller.dart';
import 'package:pbl6_app/src/screens/homeScreen/home_screen.dart';
import 'package:pbl6_app/src/screens/signUpScreens/sign_up_screen.dart';
import 'package:pbl6_app/src/values/app_assets.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/rounded_button.dart';
import 'package:pbl6_app/src/widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                'Đăng nhập',
                style: AppStyles.textBold.copyWith(color: AppColors.mainColor1),
              ),
              const SizedBox(
                height: 40,
              ),
              loginForm(context, size),
            ],
          ),
        ),
      ),
    );
  }

  Column loginForm(BuildContext context, Size size) {
    return Column(
      children: [
        TextFieldContainer(
          child: TextField(
            controller: loginController.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.mail_outline_rounded,
                color: Colors.black38,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: "Email",
              hintStyle:
                  AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: loginController.passwordController,
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
        Container(
            padding: const EdgeInsets.only(right: 40, top: 10),
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Get.toNamed("/forgetpassword");
              },
              child: Text(
                'Quên mật khẩu?',
                style: AppStyles.textBold
                    .copyWith(color: AppColors.mainColor1, fontSize: 16),
              ),
            )),
        // Button Login
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(top: 29),
          alignment: Alignment.center,
          child: RoundedButton(
            press: () async {
              //check
              await loginController.login();
            },
            text: 'Đăng nhập',
            size: Size(size.width * 0.8, 56),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Không có tài khoản? ",
              style: AppStyles.textMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
              child: Text("Tạo tài khoản",
                  style: AppStyles.textBold
                      .copyWith(color: AppColors.mainColor1, fontSize: 16.0)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Hoặc",
          style: AppStyles.textMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColors.borderGray)),
          child: GestureDetector(
            child: Image.asset(
              AppAssets.googleImage,
              width: 60,
              height: 60,
            ),
            onTap: () {
              Get.to(const HomeScreen());
            },
          ),
        ),
      ],
    );
  }
}
