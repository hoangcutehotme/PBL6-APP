import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/OrderController/order_shipper_controller.dart';
import 'package:pbl6_app/src/controller/ShipperController/statistic_order_shipper_controller.dart';
import 'package:pbl6_app/src/widgets/bar_char_example.dart';

import '../../../controller/func/func_useful.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_styles.dart';
import 'list_order_in_day.dart';

class DailyStatisticTab extends StatefulWidget {
  const DailyStatisticTab({super.key});

  @override
  State<DailyStatisticTab> createState() => _DailyStatisticTabState();
}

class _DailyStatisticTabState extends State<DailyStatisticTab> {
  final DatePickerController _controller = DatePickerController();
  StaticOrderShipperController statisticController =
      Get.put(StaticOrderShipperController(orderStatisticRepo: Get.find()));
  OrderShipperController orderShipperController = Get.find();
  void executeAfterBuild() {
    statisticController.getDataDay();
    _controller.jumpToSelection();
  }

  DateTime _selectedDate = DateTime.now();

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _datePickerTimeline(),
        GetBuilder<StaticOrderShipperController>(builder: (_) {
          statisticController.getDataDay();
          var dataDay = statisticController.dataDay;

          return statisticController.listDataDay == []
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thu nhập hiện tại ${FuncUseful.stringDateTimeToDayMonthYear(statisticController.selectedDate)}',
                            style: AppStyles.textMedium.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          AspectRatio(
                            aspectRatio: 1.1,
                            child: BarChartSample1(
                              listData: statisticController.listDataDay,
                            ),
                          ),
                          Text(
                              'Tổng cộng : ${FuncUseful.formartStringPrice(dataDay.revenue ?? 0)}đ',
                              style: AppStyles.textMedium
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Text(
                              'Số đơn hàng đã hoàn thành : ${FuncUseful.formartStringPrice(dataDay.count ?? 0)}',
                              style: AppStyles.textMedium
                                  .copyWith(fontWeight: FontWeight.w600)),
                          TextButton(
                            onPressed: () {
                              orderShipperController.getListOrderInDay(
                                  statisticController.selectedDate);
                              Get.to(() => ListOrderInDay(
                                  selectedDate:
                                      statisticController.selectedDate));
                            },
                            child: Row(
                              children: [
                                Text("Xem danh sách đơn hàng",
                                    style: AppStyles.textMedium.copyWith(
                                        color: AppColors.mainColor1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: AppColors.mainColor1,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ]),
    );
  }

  Container _datePickerTimeline() {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 98)),
        height: 100,
        width: 60,
        controller: _controller,
        initialSelectedDate: _selectedDate,
        daysCount: 100,
        inactiveDates: List.generate(
          2,
          (index) => DateTime.now().add(Duration(days: index + 1)),
        ),
        deactivatedColor: AppColors.borderGray,
        selectionColor: AppColors.colorButton1,
        selectedTextColor: Colors.white,
        dateTextStyle:
            AppStyles.textMedium.copyWith(fontWeight: FontWeight.w600),
        onDateChange: (selectedDate) {
          _selectedDate = selectedDate;
          statisticController.updateSelectedDate(selectedDate);
          statisticController.getDataDay();
          orderShipperController.getListOrderInDay(selectedDate);
          // await statisticController.dailyStatistic();
        },
        locale: 'vi_VN',
      ),
    );
  }
}
