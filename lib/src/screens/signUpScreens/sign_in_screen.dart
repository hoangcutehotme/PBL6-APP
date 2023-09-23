import 'package:flutter/material.dart';
import 'package:pbl6_app/src/screens/homeScreen/home_screen.dart';
import 'package:pbl6_app/src/screens/signUpScreens/sign_up_screen.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_fonts.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/rounded_button.dart';
import 'package:pbl6_app/src/widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              const Text(
                'Login',
                style: AppStyles.textBold,
              ),
              Text('Hi,Welcome',
                  style: AppStyles.textMedium.copyWith(
                    color: AppColors.colorTextBlur,
                    fontSize: 24,
                  )),
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
            // controller: authController.loginEmailController,
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
            // controller: authController.loginEmailController,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.black38,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: "Password",
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
              onTap: () {},
              child: Text(
                'Forgot Password?',
                style: AppStyles.textMedium.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.mainColorBlue,
                ),
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
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ),
              );
            },
            text: 'Login',
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
              "Don't have account? ",
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
              child: Text("Create account",
                  style: AppStyles.textBold.copyWith(
                      color: AppColors.mainColorBlue, fontSize: 16.0)),
            ),
          ],
        ),
      ],
    );
  }
}
