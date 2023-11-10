import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/fill_label_text.dart';
import 'package:pbl6_app/src/widgets/rounded_button.dart';

import '../../controller/Authentication/register_controller.dart';

class FillInfoUserScreen extends StatefulWidget {
  const FillInfoUserScreen({super.key});

  @override
  State<FillInfoUserScreen> createState() => _FillInfoUserScreenState();
}

class _FillInfoUserScreenState extends State<FillInfoUserScreen> {
  final RegisterController _controller = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                size: Size(size.width * 0.85, 56),
                label: 'Họ ',
                child: TextField(
                  controller: _controller.lastnameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Họ",
                    hintStyle: AppStyles.textMedium
                        .copyWith(color: AppColors.colorTextBlur),
                    border: InputBorder.none,
                  ),
                ),
              ),
              FillLabelText(
                size: Size(size.width * 0.85, 56),
                label: 'Tên',
                child: TextField(
                  controller: _controller.firstnameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Tên",
                    hintStyle: AppStyles.textMedium
                        .copyWith(color: AppColors.colorTextBlur),
                    border: InputBorder.none,
                  ),
                ),
              ),

              FillLabelText(
                size: Size(size.width * 0.85, 56),
                label: 'Địa chỉ',
                child: TextField(
                  controller: _controller.addressController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Điạ chỉ",
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
                  press: () async {
                    await Get.find<RegisterController>().registerUserEmail();

                    await Get.toNamed("/verifyotp");
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
