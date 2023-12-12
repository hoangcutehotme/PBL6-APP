// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pbl6_app/src/controller/ShipperController/statistic_order_shipper_controller.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

import '../model/status_statistic.dart';

class BarChartSample1 extends StatefulWidget {
  final List<StatisticModel> listData;
  BarChartSample1({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final Color barBackgroundColor = AppColors.colorButton1.withOpacity(0.2);
  final Color barColor = AppColors.colorButton1.withOpacity(0.9);
  final Color touchedBarColor = AppColors.mainColor1;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  StaticOrderShipperController statisticController = Get.find();
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GetBuilder<StaticOrderShipperController>(
                        builder: (context) {
                      return BarChart(
                        mainBarData(widget.listData),
                        swapAnimationDuration: animDuration,
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 12,
    List<int> showTooltips = const [0],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 50,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups2(List<StatisticModel> listdata) =>
      List.generate(listdata.length, (i) {
        return makeGroupData(i, listdata[i].revenue!.toDouble(),
            isTouched: i == touchedIndex);
      });

  // Bar
  BarChartData mainBarData(List<StatisticModel> listData) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        // touchExtraThreshold: const EdgeInsets.only(right: 50),
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: const EdgeInsets.only(bottom: 10),
          tooltipBgColor: AppColors.mainColorBackground,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: 0,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY == 0 ? '' : '${rod.toY.round() ~/ 1000}k',
              const TextStyle(
                color: AppColors.mainColor1,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      // value x,y top and right
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      //
      borderData: FlBorderData(
        show: false,
      ),
      groupsSpace: 10,
      barGroups: showingGroups2(listData),
      gridData: const FlGridData(show: false), //
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.colorTextBlur,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
          DateFormat('d/MM').format(widget.listData[value.toInt()].date!),
          style: style),
    );
  }
}
