import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/fill_label_text.dart';
import 'package:pbl6_app/src/widgets/rounded_button.dart';

class FillInfoUserScreen extends StatefulWidget {
  const FillInfoUserScreen({super.key});

  @override
  State<FillInfoUserScreen> createState() => _FillInfoUserScreenState();
}

class _FillInfoUserScreenState extends State<FillInfoUserScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AppBar(
                foregroundColor: AppColors.colorTextBold,
                backgroundColor: AppColors.mainColorBackground,
                shadowColor: Colors.transparent,
              ),
              Text(
                "Thông tin cá nhân",
                style: AppStyles.textBold
                    .copyWith(color: AppColors.mainColor1, fontSize: 24),
              ),
              // fill info
              FillLabelText(
                label: 'Họ và tên',
                child: TextField(
                  // controller: authController.loginEmailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Họ và tên",
                    hintStyle: AppStyles.textMedium
                        .copyWith(color: AppColors.colorTextBlur),
                    border: InputBorder.none,
                  ),
                ),
              ),

              FillLabelText(
                label: 'Ảnh đại diện',
                child: TextField(
                  // controller: authController.loginEmailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Ảnh đại diện",
                    hintStyle: AppStyles.textMedium
                        .copyWith(color: AppColors.colorTextBlur),
                    border: InputBorder.none,
                  ),
                ),
              ),
              FillLabelText(
                label: 'Họ và tên',
                child: TextField(
                  // controller: authController.loginEmailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Họ và tên",
                    hintStyle: AppStyles.textMedium
                        .copyWith(color: AppColors.colorTextBlur),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 29),
                alignment: Alignment.center,
                child: RoundedButton(
                  press: () {
                    Get.toNamed("/verifyotp");
                  },
                  text: 'Xác nhận',
                  size: Size(size.width * 0.8, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
