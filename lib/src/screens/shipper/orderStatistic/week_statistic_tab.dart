import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/statistic_order_shipper_controller.dart';
import 'package:pbl6_app/src/widgets/bar_char_example.dart';

import '../../../values/app_styles.dart';

// import '../../values/app_colors.dart';

class WeekStatisticTab extends StatelessWidget {
  WeekStatisticTab({super.key});

  StaticOrderShipperController statisticController =
      Get.put(StaticOrderShipperController(orderStatisticRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GetBuilder<StaticOrderShipperController>(
              initState: (state) => statisticController.weekStatistic(),
              builder: (_) {
                return statisticController.dataWeek == []
                    ? const Center(
                        heightFactor: 200,
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Thu nhập theo tuần ',
                                  style: AppStyles.textMedium.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: BarChartSample1(
                                    listData: statisticController.dataWeek,
                                  ),
                                ),
                                // Text(
                                //     'Tổng cộng : ${FuncUseful.formartStringPrice(dataDay.revenue ?? 0)}',
                                //     style: AppStyles.textMedium
                                //         .copyWith(fontWeight: FontWeight.w500)),
                                // Text(
                                //     'Số đơn hàng đã hoàn thành : ${FuncUseful.formartStringPrice(dataDay.count ?? 0)}',
                                //     style: AppStyles.textMedium
                                //         .copyWith(fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ],
                      );
              }),
        ]),
      ),
    );
  }
}
