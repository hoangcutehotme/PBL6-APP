import 'package:get/get.dart';


class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
   
}
