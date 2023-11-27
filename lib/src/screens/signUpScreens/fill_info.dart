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

              Visibility(
                  visible: !_controller.isUser.value,
                  child: Column(
                    children: [
                      FillLabelText(
                        size: Size(size.width * 0.85, 56),
                        label: 'Loại xe',
                        child: TextField(
                          controller: _controller.vehicleTypeController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            hintText: "Loại xe",
                            hintStyle: AppStyles.textMedium
                                .copyWith(color: AppColors.colorTextBlur),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      FillLabelText(
                        size: Size(size.width * 0.85, 56),
                        label: 'Số xe',
                        child: TextField(
                          controller: _controller.vehicleNumberController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            hintText: "Số xe",
                            hintStyle: AppStyles.textMedium
                                .copyWith(color: AppColors.colorTextBlur),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Mặt trước CCCD',
                                    style: AppStyles.textMedium
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.borderGray),
                                      onPressed: () {
                                        _controller.getFrontCCCDImage();
                                      },
                                      child: Text(
                                          _controller.frontCCCDImage?.path ==
                                                  null
                                              ? 'Choose image'
                                              : 'frontImage.jpg')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Mặt sau CCCD',
                                    style: AppStyles.textMedium
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.borderGray),
                                      onPressed: () {
                                        _controller.getBehindCCCDImage();
                                      },
                                      child: Text(
                                          _controller.behindCCCDImage?.path ==
                                                  null
                                              ? 'Choose image'
                                              : 'behindImage.jpg')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Giấy phép lái xe',
                                    style: AppStyles.textMedium
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.borderGray),
                                      onPressed: () {
                                        _controller.getLicenseImage();
                                      },
                                      child: Text(
                                          _controller.licenseImage?.path == null
                                              ? 'Choose image'
                                              : 'licenseImage.jpg')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Giấy đăng ký xe',
                                    style: AppStyles.textMedium
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.borderGray),
                                      onPressed: () {
                                        _controller.getVehicleImage();
                                      },
                                      child: Text(
                                          _controller.vehicleImage?.path == null
                                              ? 'Choose image'
                                              : 'vehicleImage.jpg')),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  )),

              Container(
                margin: const EdgeInsets.only(top: 29),
                alignment: Alignment.center,
                child: RoundedButton(
                  press: () async {
                    if (_controller.isUser.value) {
                      await Get.find<RegisterController>().registerUserEmail();

                      await Get.toNamed("/verifyotp");
                    } else {
                      await Get.find<RegisterController>()
                          .registerShipperEmail();

                      await Get.toNamed("/verifyotp");
                    }
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
