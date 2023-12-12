// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

import 'package:pbl6_app/src/data/repository/order_static_repository.dart';
import 'package:pbl6_app/src/model/status_statistic.dart';

class StaticOrderShipperController extends GetxController {
  OrderStatisticRepo orderStatisticRepo;
  StaticOrderShipperController({
    required this.orderStatisticRepo,
  });

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  StatisticModel _dataDay = StatisticModel();
  StatisticModel get dataDay => _dataDay;

  List<StatisticModel> _listDataDay = [];
  List<StatisticModel> get listDataDay => _listDataDay;

  List<StatisticModel> _dataWeek = [];
  List<StatisticModel> get dataWeek => _dataWeek;

  List<StatisticModel> _dataMonth = [];
  List<StatisticModel> get dataMonthDay => _dataMonth;

  @override
  onInit() async {
    await dailyStatistic();
    await getDataDay();

    super.onInit();
  }

  updateSelectedDate(DateTime date) {
    _selectedDate = date;
    update();
  }

  getDataDay() async {
    try {
      if (_listDataDay.isNotEmpty) {
        var getData = _listDataDay.firstWhere(
          (value) =>
              value.date!.day == selectedDate.day &&
              value.date!.month == selectedDate.month &&
              value.date!.year == selectedDate.year,
          // orElse: () =>
          //     StatisticModel(), // Return default StatisticModel if no match found
        );
        _dataDay = getData;
        update();
      }
    } catch (e) {
      print('error $e');
    }
  }

  dailyStatistic() async {
    try {
      final response = await orderStatisticRepo.getStatisticDaily();
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var listData = statisticModelFromJson(jsonEncode(body["data"]));
        _listDataDay = listData;
        update();
      } else {
        _listDataDay = [];
        update(); // Return an empty list in case of other status codes
      }
    } catch (e) {}
  }

  monthlyStatistic() async {
    try {
      final response = await orderStatisticRepo.getStatisticMonth();
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var listData = statisticModelFromJson(jsonEncode(body["data"]));
        _dataMonth = listData;
        update();
      } else {
        _dataMonth = [];
        update(); // Return an empty list in case of other status codes
      }
    } catch (e) {}
  }

  weekStatistic() async {
    try {
      final response = await orderStatisticRepo.getStatisticWeek();
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var listData = statisticModelFromJson(jsonEncode(body["data"]));
        _dataWeek = listData;
        update();
      } else {
        _dataWeek = [];
        update(); // Return an empty list in case of other status codes
      }
    } catch (e) {}
  }
}
