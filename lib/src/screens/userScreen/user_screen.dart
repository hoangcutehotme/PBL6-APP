import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/UserController/user_controller.dart';
import 'package:pbl6_app/src/screens/userScreen/change_user_info.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../../controller/Authentication/login_controller.dart';
import '../../values/app_assets.dart';
import 'list_contact.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final LoginController _controller = Get.put(LoginController());
  // final UserController _userController = Get.put(UserController());
  final UserController _userController = Get.find();

  @override
  void initState() {
    super.initState();
    // _initializeUser();
  }

  _initializeUser() async {
    await _userController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.placeholder,
      body: Column(
        children: [
          _headerTopBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  key: const Key('changeUserButton'),
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

  Container _headerTopBar() {
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
                  () =>
                      // _userController.isLoading.value
                      //     ? const CircularProgressIndicator(
                      //         color: AppColors.borderGray,
                      //       )
                      //     :
                      Text(
                    _userController.id.value == ''
                        ? 'Người dùng'
                        : "${_userController.user.value.lastName ?? ''} ${_userController.user.value.firstName ?? ''}",
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
