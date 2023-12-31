// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pbl6_app/src/data/repository/order_repository.dart';
import 'package:pbl6_app/src/helper/func/func_useful.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../../model/order_detail_shipper.dart';

class ChangeStepperOrder extends GetxController {
  OrderRepo orderRepo;
  ChangeStepperOrder({
    required this.orderRepo,
  });
  int _currentStep = 0;
  int get currentStep => _currentStep;
  List<Step> _listStep = [
    Step(title: const Text('Đơn đã đặt'), content: Container()),
    Step(
        title: const Text('Đã xác nhận thông tin thanh toán'),
        content: Container()),
    Step(title: const Text('Đang chuẩn bị đơn hàng'), content: Container()),
    Step(title: const Text('Đang trên đường giao hàng '), content: Container()),
    Step(title: const Text('Đã giao hàng thành công'), content: Container()),
  ];
  List<Step> get listStep => _listStep;

  OrderDetailShipper _order = OrderDetailShipper();
  OrderDetailShipper get order => _order;

  @override
  void onClose() {
    _listStep.clear();
  }

  getStep(String id) async {
    var response = await orderRepo.getOrderDetail(id);

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      _order = OrderDetailShipper.fromJson(jsonBody['data']);
      update();

      if (order.dateOrdered == null) {
      } else if (order.dateCheckout == null) {
        _currentStep = 0;
      } else if (order.datePrepared == null) {
        _currentStep = 1;
      } else if (order.dateDeliveried == null) {
        _currentStep = 2;
      } else if (order.dateFinished == null) {
        _currentStep = 3;
      } else {
        _currentStep = 4;
      }
      update();
    } else {
      
    }

    List<Step> list = [
      Step(
          subtitle:
              // order.dateOrdered == null
              //     ? null
              //     :
              Text(FuncUseful.stringDateTimeToDayAndTime(order.dateOrdered)),
          isActive: _currentStep >= 0,
          title: const Text('Đơn đã đặt'),
          content: Container()),
      Step(
          subtitle:
              // order.dateCheckout == null
              //     ? null
              //     :
              Text(FuncUseful.stringDateTimeToDayAndTime(order.dateCheckout)),
          isActive: _currentStep >= 1,
          title: const Text('Đã xác nhận thông tin thanh toán'),
          content: Container()),
      Step(
          subtitle: order.datePrepared == null
              ? null
              : Text(FuncUseful.stringDateTimeToDayAndTime(order.datePrepared)),
          isActive: _currentStep >= 2,
          title: const Text('Đang chuẩn bị đơn hàng'),
          content: Container(
            child: order.datePrepared == null
                ? null
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cửa hàng :',
                        style: AppStyles.textMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        order.store!.name!,
                        style: AppStyles.textMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        order.store!.address!,
                        style: AppStyles.textMedium,
                      )
                    ],
                  ),
          )),
      Step(
          subtitle: order.dateDeliveried == null
              ? null
              : Text(
                  FuncUseful.stringDateTimeToDayAndTime(order.dateDeliveried)),
          isActive: _currentStep >= 3,
          title: const Text('Đang giao'),
          content: Container(
            child: order.dateDeliveried == null
                ? null
                : Row(
                    children: [
                      Text(
                        'Người giao hàng: ${order.shipper!.lastName} ${order.shipper!.firstName}',
                        style: AppStyles.textMedium,
                      ),
                    ],
                  ),
          )),
      Step(
          subtitle: order.dateFinished == null
              ? null
              : Text(FuncUseful.stringDateTimeToDayAndTime(order.dateFinished)),
          isActive: _currentStep >= 4,
          title: const Text('Đã giao hàng thành công'),
          content: Container(
            margin: const EdgeInsets.only(left: 0),
            child: Row(
              children: [
                Text(
                  '${order.shipper!.lastName} ${order.shipper!.firstName} đã giao hàng thành công ',
                  style: AppStyles.textMedium.copyWith(fontSize: 14),
                ),
              ],
            ),
          )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       '${order.shipper!.lastName} ${order.shipper!.firstName} ',
          //       style: AppStyles.textMedium.copyWith(fontSize: 14),
          //     ),
          //   ],
          // )
          ),
    ];
    _listStep = [];
    _listStep = list;
    update();
  }

  getStepWithOrder(OrderDetailShipper order) async {
    _order = order;
    update();

    if (order.dateOrdered == null) {
    } else if (order.dateCheckout == null) {
      _currentStep = 0;
    } else if (order.datePrepared == null) {
      _currentStep = 1;
    } else if (order.dateDeliveried == null) {
      _currentStep = 2;
    } else if (order.dateFinished == null) {
      _currentStep = 3;
    } else {
      _currentStep = 4;
    }
    update();

    List<Step> list = [
      Step(
          subtitle:
              // order.dateOrdered == null
              //     ? null
              //     :
              Text(FuncUseful.stringDateTimeToDayAndTime(order.dateOrdered)),
          isActive: _currentStep >= 0,
          title: const Text('Đơn đã đặt'),
          content: Container()),
      Step(
          subtitle:
              // order.dateCheckout == null
              //     ? null
              //     :
              Text(FuncUseful.stringDateTimeToDayAndTime(order.dateCheckout)),
          isActive: _currentStep >= 1,
          title: const Text('Đã xác nhận thông tin thanh toán'),
          content: Container()),
      Step(
          subtitle: order.datePrepared == null
              ? null
              : Text(FuncUseful.stringDateTimeToDayAndTime(order.datePrepared)),
          isActive: _currentStep >= 2,
          title: const Text('Đang chuẩn bị đơn hàng'),
          content: Container(
            child: order.datePrepared == null
                ? null
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cửa hàng :',
                        style: AppStyles.textMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        order.store!.name!,
                        style: AppStyles.textMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        order.store!.address!,
                        style: AppStyles.textMedium,
                      )
                    ],
                  ),
          )),
      Step(
          subtitle: order.dateDeliveried == null
              ? null
              : Text(
                  FuncUseful.stringDateTimeToDayAndTime(order.dateDeliveried)),
          isActive: _currentStep >= 3,
          title: const Text('Đang giao'),
          content: Container(
            child: order.dateDeliveried == null
                ? null
                : Row(
                    children: [
                      Text(
                        'Người giao hàng: ${order.shipper!.lastName} ${order.shipper!.firstName}',
                        style: AppStyles.textMedium,
                      ),
                    ],
                  ),
          )),
      Step(
          subtitle: order.dateFinished == null
              ? null
              : Text(FuncUseful.stringDateTimeToDayAndTime(order.dateFinished)),
          isActive: _currentStep >= 4,
          title: const Text('Đã giao hàng thành công'),
          content: Container(
            margin: const EdgeInsets.only(left: 0),
            child: Row(
              children: [
                Text(
                  '${order.shipper!.lastName} ${order.shipper!.firstName} đã giao hàng thành công ',
                  style: AppStyles.textMedium.copyWith(fontSize: 14),
                ),
              ],
            ),
          )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       '${order.shipper!.lastName} ${order.shipper!.firstName} ',
          //       style: AppStyles.textMedium.copyWith(fontSize: 14),
          //     ),
          //   ],
          // )
          ),
    ];
    _listStep = [];
    _listStep = list;
    update();
  }
}
