import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';

import '../../controller/Authentication/login_controller.dart';
import '../../values/app_assets.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import '../userScreen/change_user_info.dart';
import '../userScreen/list_contact.dart';

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
                    Get.to(() => const ChangeUserInfo());
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
                    Get.to(() => const ListContactScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColorBackground,
                        borderRadius: BorderRadius.circular(5)),
                    child: const ListTile(
                      contentPadding: EdgeInsets.only(left: 25),
                      title: Text("Thay đổi địa chỉ giao hàng"),
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
                    _controller.logout();
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
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  AppAssets.getImg("user_avartar2.png", "images"),
                  width: 80,
                  height: 80,
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
                        color: AppColors.mainColorBackground, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
