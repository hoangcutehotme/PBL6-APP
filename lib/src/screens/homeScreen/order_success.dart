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
          const Center(child: Text("Order Success")),
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
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.offAllNamed("/home");
      },
    ),
  );
}
