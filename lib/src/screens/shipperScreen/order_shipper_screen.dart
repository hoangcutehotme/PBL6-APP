import 'package:flutter/material.dart';
import 'package:pbl6_app/src/screens/shipperScreen/daily_statistic_tab.dart';
import 'package:pbl6_app/src/screens/shipperScreen/month_statistic_tab.dart';
import 'package:pbl6_app/src/screens/shipperScreen/week_statistic_tab.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class StatisticShipperScreen extends StatefulWidget {
  const StatisticShipperScreen({super.key});

  @override
  State<StatisticShipperScreen> createState() => _OrderShipperScreenState();
}

class _OrderShipperScreenState extends State<StatisticShipperScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Thông kê đơn hàng',
                    style: AppStyles.textBold.copyWith(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 240,
            // padding: const EdgeInsets.all(8.0),
            child: TabBar(
              labelPadding: const EdgeInsets.symmetric(horizontal: 2),
              indicatorColor: Colors.white,
              indicator: null,
              automaticIndicatorColorAdjustment: false,
              padding: const EdgeInsets.only(top: 10),
              labelColor: AppColors.mainColor1,
              unselectedLabelColor: AppColors.grayBold,
              labelStyle:
                  AppStyles.textMedium.copyWith(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: "Ngày"),
                Tab(
                  text: "Tuần",
                ),
                Tab(text: 'Tháng')
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                DailyStatisticTab(),
                WeekStatisticTab(),
                MonthStatisticTab()
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
