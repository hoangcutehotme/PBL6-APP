// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pbl6_app/src/controller/func/func_useful.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';

import '../../controller/OrderController/order_controller.dart';
import '../../controller/StoreController/cart_controller.dart';
import '../../controller/StoreController/store_detail_controller.dart';
import '../../model/cart_model.dart';
import '../../model/shipper_order.dart';
import '../../values/app_styles.dart';
import '../../widgets/food_cell_cart.dart';
import '../../widgets/image_loading_network.dart';

class OrderDetailShipperScreen extends StatefulWidget {
  const OrderDetailShipperScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailShipperScreen> createState() =>
      _OrderDetailShipperScreenState();
}

class _OrderDetailShipperScreenState extends State<OrderDetailShipperScreen> {
  int widthOrder = 90;
  bool isListShortened = true;
  bool showFull = false;

  String id = Get.arguments;

  // Function to toggle list length
  void toggleListLength() {
    setState(() {
      isListShortened = !isListShortened;
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.find();
    // OrderController orderController = Get.put(
    //     OrderController(orderRepo: Get.find(), userController: Get.find()));
    return Scaffold(
      appBar: AppWidget.appBar('Chi tiết đơn hàng'),
      body: GetBuilder<OrderController>(
        initState: (state) => orderController.showOrderDetail(id),
        builder: (controller)  {
        var detailOrder = orderController.orderShipper;
        return !detailOrder.isDefinedAndNotNull
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Container(
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle_outline),
                        Text('Trạng thái đơn hàng'),
                        Spacer(),
                        Text('time'),
                      ],
                    ),
                  ),
                  Container(
                    child: const Column(children: [
                      Text('Địa chỉ cửa hàng'),
                      Text('Address'),
                    ]),
                  ),
                  // _orderDetail(detailOrder),
                  Row(
                    children: [
                      const Text('Tổng cộng :'),
                      Text("${FuncUseful.formartStringPrice(2500000)}đ"),
                    ],
                  ),
                  Container(
                    child: const Column(
                      children: [
                        Text('Giao đến'),
                        Text('Address'),
                      ],
                    ),
                  )
                ]),
              );
      }),
    );
  }

  _orderDetail(List<CartModel> carts) {
    CartController cartController = Get.find();
    return GetBuilder<CartController>(builder: (_) {
      var listProducts = cartController.products.values;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              Get.find<StoreDetailController>().store.name ?? '',
              style: AppStyles.textMedium
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: isListShortened
                ? widthOrder.toDouble()
                : listProducts.length.toDouble() * widthOrder,
            child: ListView.builder(
              itemCount: listProducts.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                var cartProduct = listProducts.elementAt(index);
                if (isListShortened && index >= 2) {
                  return const SizedBox.shrink(); // Hide items beyond index 4
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () {
                      Get.bottomSheet(
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: GetBuilder<CartController>(builder: (_) {
                                  var products = listProducts.toList();
                                  return ListView.separated(
                                      itemBuilder: (_, index) {
                                        return FoodInfoCellCart(
                                          controller: cartController,
                                          product: products[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          thickness: 2,
                                        );
                                      },
                                      itemCount: products.length);
                                }),
                              ),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    leading: ImageLoadingNetwork(
                        image: cartProduct.images![0],
                        size: const Size(60, 70)),
                    title: Text(
                      "${cartProduct.quantity} x ${cartProduct.name}",
                      style: AppStyles.textSmall
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    trailing: Text(
                      "${(cartProduct.price.toInt()) * (cartProduct.quantity)}đ",
                      style: AppStyles.textMedium
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ),
          // Button to toggle list length
          listProducts.length > 1
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextButton(
                        onPressed: toggleListLength,
                        child: Text(isListShortened ? 'Xem thêm' : 'Thu gọn'),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      );
    });
  }
}
