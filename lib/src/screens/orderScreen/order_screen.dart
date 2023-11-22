import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/OrderController/order_controller.dart';
import 'package:pbl6_app/src/screens/orderScreen/comming_order.dart';
import 'package:pbl6_app/src/screens/orderScreen/history_order.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(OrderController(userController: Get.find()));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 25),
            TabBar(
              indicatorColor: AppColors.mainColor1,
              labelColor: AppColors.mainColor1,
              unselectedLabelColor: AppColors.grayBold,
              labelStyle:
                  AppStyles.textMedium.copyWith(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: "Đang đến"),
                Tab(
                  text: "Lịch sử",
                )
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CommingOrderTab(),
                  HistoryOrderTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
