import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../values/app_colors.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          const Center(child: Text("Bạn đã đặt hàng thành công")),
        ],
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    foregroundColor: AppColors.mainColor1,
    backgroundColor: AppColors.mainColorBackground,
    shadowColor: Colors.transparent,
    actions: [
      IconButton(
        icon: const Icon(Icons.home_filled),
        onPressed: () {
          Get.offAllNamed("/home");
        },
      ),
    ],
    // leading: IconButton(
    //   icon: const Icon(Icons.arrow_back),
    //   onPressed: () {
    //     Get.offAllNamed("/home");
    //   },
    // ),
  );
}
