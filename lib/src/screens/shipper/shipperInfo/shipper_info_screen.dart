import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/utils/custome_dialog.dart';
import 'package:pbl6_app/src/widgets/image_loading_network.dart';

import '../../../controller/Authentication/login_controller.dart';
import '../../../values/app_assets.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_styles.dart';
import 'change_shipper_info.dart';

class ShipperInfoScreen extends StatelessWidget {
  ShipperInfoScreen({super.key});
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    ShipperController shipperController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.placeholder,
      body: Column(
        children: [
          _headerTopBar(shipperController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ChangeShipperInfo());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColorBackground,
                        borderRadius: BorderRadius.circular(5)),
                    child: const ListTile(
                      contentPadding: EdgeInsets.only(left: 25),
                      title: Text("Thay đổi thông tin cá nhân"),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.colorTextBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    CustomeDialog.showCustomDialog1(
                        context: context,
                        title: 'Thông báo',
                        message: 'Bạn có chắc Đăng xuất ??',
                        pressConfirm: () {
                          _controller.logout();
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColorBackground,
                        borderRadius: BorderRadius.circular(5)),
                    child: const ListTile(
                      contentPadding: EdgeInsets.only(left: 25),
                      title: Text("Đăng xuất"),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.colorTextBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _headerTopBar(ShipperController shipperController) {
    return Container(
      // width: double.maxFinite,
      height: 180,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.mainColor1, AppColors.colorButton1])),
      child: GetBuilder<ShipperController>(
          initState: (state) => shipperController.getInfoShipperrById(),
          builder: (_) {
            return Stack(
              children: [
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      shipperController.user.value.photo == null
                          ? Image.asset(
                              AppAssets.getImg("user_avartar2.png", "images"),
                              width: 80,
                              height: 80,
                            )
                          : shipperController.photo != null
                              ? Image.file(
                                  File(shipperController.photo!.path),
                                  width: 100,
                                  height: 100,
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  child: ImageLoadingNetwork(
                                      image:
                                          shipperController.user.value.photo!,
                                      size: const Size(180, 180)),
                                ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => Text(
                          shipperController.id.value == ''
                              ? 'Người dùng'
                              : "${shipperController.user.value.lastName ?? ''} ${shipperController.user.value.firstName ?? ''}",
                          style: AppStyles.textBold.copyWith(
                              color: AppColors.mainColorBackground,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
