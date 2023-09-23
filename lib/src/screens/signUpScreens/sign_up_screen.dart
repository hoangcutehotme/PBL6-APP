import 'package:flutter/material.dart';
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

  List<String> roles = ['Role 1', 'Role 2', 'Role 3', 'Role 4'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Create Account",
                style: AppStyles.textBold,
              ),
              const SizedBox(
                height: 50,
              ),
              logupForm(context, size)
            ],
          ),
        ),
      ),
    );
  }

  Column logupForm(BuildContext context, Size size) {
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
        TextFieldContainer(
          child: TextField(
            // controller: authController.loginEmailController,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.black38,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: "Confirm Password",
              hintStyle:
                  AppStyles.textMedium.copyWith(color: AppColors.colorTextBlur),
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
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
        )),
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
                    return const SignInScreen();
                  },
                ),
              );
            },
            text: 'Logup',
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
              "Already have account? ",
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
                  "Login",
                  style: AppStyles.textBold
                      .copyWith(color: AppColors.mainColorBlue, fontSize: 16),
                )),
          ],
        ),
      ],
    );
  }
}
