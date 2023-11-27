import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/searchScreen/seach_section.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0;

  void onItemTapped(int index) {
    if (index == 1) {
      // Assuming index 1 is the search tab.
      // Show the search delegate instead of switching to the search screen.
      showSearch(context: Get.context!, delegate: SearchSection());
    } else {
      // Otherwise, switch to the respective tab.
      selectedIndex = index;
    }
    update();
  }

  void onItemTappedShipper(int index) {
    selectedIndex = index;

    update();
  }
}
