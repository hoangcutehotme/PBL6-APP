import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/OrderController/order_controller.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../../widgets/image_loading_network.dart';

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
            var listOrder = controller.listOrder;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var order = listOrder[index];

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 205,
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Row(
                            children: [
                              const Text(
                                "Đơn hàng",
                                style: AppStyles.textMedium,
                              ),
                              Expanded(child: Container()),
                              Text(
                                  "${order.dateOrdered!.day}/${order.dateOrdered!.month}/${order.dateOrdered!.year} - ${order.dateOrdered!.hour}:${order.dateOrdered!.minute}",
                                  style: AppStyles.textMedium)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((order.store?.name ?? '').toString(),
                                      style: AppStyles.textMedium),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(order.totalPrice.toString(),
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
                              Text(
                                  order.status == "Pending"
                                      ? "Đang xử lý"
                                      : (order.status == "Refused"
                                          ? "Từ chối đơn hàng"
                                          : "Đang xử lý"),
                                  style: AppStyles.textMedium),
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
