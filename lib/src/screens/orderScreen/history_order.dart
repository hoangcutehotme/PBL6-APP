import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/OrderController/order_user_controller.dart';
import 'package:pbl6_app/src/helper/func/func_useful.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../../widgets/image_loading_network.dart';
import 'order_info_screen.dart';

class HistoryOrderTab extends StatefulWidget {
  const HistoryOrderTab({super.key});

  @override
  State<HistoryOrderTab> createState() => _HistoryOrderTabState();
}

class _HistoryOrderTabState extends State<HistoryOrderTab> {
  OrderController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
          initState: (state) => controller.fetchListOrder('', '', '', 1),
          builder: (_) {
            var listOrder = controller.listOrderHistory;
            return listOrder.isEmpty
                ? const Center(child: Text('Chưa có đơn hàng nào'))
                : ListView.separated(
                    itemBuilder: (context, index) {
                      var order = listOrder[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => OrderInfoScreen(
                                id: order.id!,
                              ));
                        },
                        child: Container(
                            height: 205,
                            padding: const EdgeInsets.all(10),
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                    "Đơn hàng",
                                    style: AppStyles.textMedium
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                      "${FuncUseful.stringDateTimeToDayMonthYear(order.dateOrdered!)}  ${FuncUseful.stringDateTimeToTime(order.dateOrdered!)}",
                                      style: AppStyles.textMedium.copyWith(
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                              Row(children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: ImageLoadingNetwork(
                                        image: order.store?.image ?? '',
                                        size: const Size(160, 130))),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text((order.store?.name ?? '').toString(),
                                          style: AppStyles.textMedium.copyWith(
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                          "${FuncUseful.formartStringPrice(order.totalPrice)}đ",
                                          style: AppStyles.textMedium.copyWith(
                                              color: AppColors.mainColor1,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ))
                              ]),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Text(FuncUseful.formatStatus(order.status),
                                      style: AppStyles.textMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: FuncUseful.colorStatus(
                                              order.status))),
                                ],
                              )
                            ])),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemCount: listOrder.length);
          }),
    );
  }
}
