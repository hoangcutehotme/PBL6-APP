import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';
import 'package:pbl6_app/src/screens/shipper/shipperHome/home_shipper_screen.dart';
import 'package:pbl6_app/src/screens/shipper/orderStatistic/order_statistic_shipper_screen.dart';
import 'package:pbl6_app/src/values/app_assets.dart';

import '../../controller/bottom_navi_bar_controller.dart';
import '../../values/app_colors.dart';
import 'shipperInfo/shipper_info_screen.dart';

class ShipperNaviPage extends StatefulWidget {
  const ShipperNaviPage({super.key});

  @override
  State<ShipperNaviPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<ShipperNaviPage> {
  BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());
  final List<Widget> _screens = [
    const ShipperHomePage(),
    const StatisticShipperScreen(),
    ShipperInfoScreen()
  ];

  final double size = 25;

  @override
  Widget build(BuildContext context) {
    Get.put(ShipperController(shipperRepo: Get.find()));

    return GetBuilder<BottomNavigationBarController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor1,
          unselectedItemColor: AppColors.colorTextBlur,
          items: [
            BottomNavigationBarItem(
              label: '',
              activeIcon: Image.asset(
                AppAssets.getImg('direction_icon.png', 'icons'),
                color: AppColors.mainColor1,
                width: size,
                height: size,
              ),
              icon: Image.asset(
                AppAssets.getImg('direction_icon.png', 'icons'),
                color: AppColors.grayBold,
                width: size,
                height: size,
              ),
            ),
            BottomNavigationBarItem(
                label: '',
                activeIcon: Image.asset(
                  AppAssets.getImg('order_icon.png', 'icons'),
                  color: AppColors.mainColor1,
                  width: size,
                  height: size,
                ),
                icon: Image.asset(
                  AppAssets.getImg('order_icon.png', 'icons'),
                  color: AppColors.grayBold,
                  width: size,
                  height: size,
                )),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.person,
                size: size + 5,
              ),
            ),
          ],
          currentIndex: controller.selectedIndex,
          onTap: controller.onItemTappedShipper,
        ),
        body: GetBuilder<BottomNavigationBarController>(
          builder: (controller) => _screens[controller.selectedIndex],
        ),
      );
    });
  }
}
