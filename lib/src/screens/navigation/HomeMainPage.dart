import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/bottom_navi_bar_controller.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

import '../homeScreen/home_screen.dart';
import '../orderScreen/order_screen.dart';
import '../searchScreen/search_screen.dart';
import '../userScreen/user_screen.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final BottomNavigationBarController _controller =
      Get.put(BottomNavigationBarController());

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    OrderScreen(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor1,
          unselectedItemColor: AppColors.colorTextBlur,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 30,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'User',
            ),
          ],
          currentIndex: _controller.selectedIndex,
          onTap: _controller.onItemTapped,
        ),
        body: GetBuilder<BottomNavigationBarController>(
          builder: (controller) => _screens[controller.selectedIndex],
        ),
      );
    });
  }
}
