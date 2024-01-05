import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';

import '../../../controller/OrderController/order_shipper_controller.dart';
import '../../../controller/ShipperController/statistic_order_shipper_controller.dart';
import '../../../helper/func/func_useful.dart';
import '../../../values/app_colors.dart';
import 'order_detail.dart';


class ListOrderInDay extends StatelessWidget {
  final DateTime selectedDate;

  ListOrderInDay({super.key, required this.selectedDate});

  StaticOrderShipperController statisticController = Get.find();
  OrderShipperController orderShipperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget.appBar("Danh sách đơn hàng"),
      body: Column(
        children: [_listOrderInDay()],
      ),
    );
  }

  _listOrderInDay() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ngày ${FuncUseful.stringDateTimeToDayMonthYear(selectedDate)}",
              style: AppStyles.textMedium
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GetBuilder<OrderShipperController>(
                  initState: (state) =>
                      orderShipperController.getListOrderInDay(selectedDate),
                  builder: (_) {
                    var listOrderInDay =
                        orderShipperController.listOrderShipperInDay;
                    return listOrderInDay == []
                        ? const Center(child: Text('Chưa có đơn hàng nào'))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              var order = listOrderInDay[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => const OrderDetail2(),
                                      arguments: order.id);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: AppColors.borderGray),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Đơn hàng ${order.id ?? ''}",
                                                  style: AppStyles.textMedium
                                                      .copyWith(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                                // Text(
                                                //   order.store?.name ?? '',
                                                //   style: AppStyles.textMedium
                                                //       .copyWith(
                                                //           fontSize: 17,
                                                //           fontWeight:
                                                //               FontWeight.w600),
                                                // ),
                                                // Text(
                                                //   "Đặt lúc: ${FuncUseful.stringDateTimeToDayAndTime(order.dateOrdered!)}",
                                                //   style: AppStyles.textMedium
                                                //       .copyWith(
                                                //           fontSize: 17,
                                                //           fontWeight:
                                                //               FontWeight.w600),
                                                // ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Trạng thái',
                                                      style: AppStyles
                                                          .textMedium
                                                          .copyWith(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      FuncUseful.formatStatus(
                                                          order.status ?? ''),
                                                      style: AppStyles
                                                          .textMedium
                                                          .copyWith(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: FuncUseful
                                                                  .colorStatus(order
                                                                      .status)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: listOrderInDay.length);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
