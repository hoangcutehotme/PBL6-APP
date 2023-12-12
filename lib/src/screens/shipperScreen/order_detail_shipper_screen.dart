import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ShipperController/shipper_controller.dart';

import 'package:pbl6_app/src/controller/func/func_useful.dart';
import 'package:pbl6_app/src/model/order_detail_shipper.dart';
import 'package:pbl6_app/src/utils/custome_dialog.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';

import '../../controller/OrderController/order_shipper_controller.dart';
import '../../utils/custome_snackbar.dart';
import '../../values/app_styles.dart';
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
  int widthOrder = 85;
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
    OrderShipperController orderController = Get.put(OrderShipperController(
        orderRepo: Get.find(), shipperController: Get.find()));

    return Scaffold(
      appBar: AppWidget.appBar('Chi tiết đơn hàng'),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<OrderShipperController>(
              initState: (state) => orderController.showOrderDetail(id),
              builder: (_) {
                var detailOrder = orderController.orderShipper;
                var store = detailOrder.store;
                var user = detailOrder.user;
                var cart = detailOrder.cart;

                return detailOrder.id == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          _statusOrder(detailOrder),
                          _infoStore(store),
                          _infoOrderer(user, detailOrder),
                          _orderDetail(cart ?? []),
                          _totalPriceAndShipFee(detailOrder),
                          const SizedBox(
                            height: 20,
                          ),
                          _buttonStatusOrder(detailOrder, orderController),
                        ]),
                      );
              }),
        ],
      )),
    );
  }

  Column _totalPriceAndShipFee(OrderDetailShipper detailOrder) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                'Phí ship : ${FuncUseful.formartStringPrice(detailOrder.shipCost)}đ',
                style:
                    AppStyles.textMedium.copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Tổng cộng : ',
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
              Text("${FuncUseful.formartStringPrice(detailOrder.totalPrice!)}đ",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }

  Padding _infoOrderer(User? user, OrderDetailShipper orderDetail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppColors.mainColor1)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giao đến:',
                        style: AppStyles.textBold.copyWith(fontSize: 16),
                      ),
                      Text(
                        '${user?.lastName} ${user?.firstName}',
                        style: AppStyles.textBold.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        orderDetail.contact?.address ?? '',
                        style: AppStyles.textMedium
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _infoStore(Store? store) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.blueAccent)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Địa chỉ:',
              style: AppStyles.textBold.copyWith(fontSize: 16),
            ),
            Text(
              store?.name ?? '',
              style: AppStyles.textBold
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              store?.address ?? '',
              style: AppStyles.textMedium,
            ),
          ]),
        ),
      ),
    );
  }

  Row _statusOrder(OrderDetailShipper detailOrder) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.orange,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'Trạng thái',
          style: AppStyles.textMedium
              .copyWith(color: Colors.orange, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          FuncUseful.formatStatus(detailOrder.status),
          style: AppStyles.textMedium
              .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  _buttonStatusOrder(OrderDetailShipper detailOrder,
      OrderShipperController orderShipperController) {
    return GetBuilder<OrderShipperController>(builder: (_) {
      return detailOrder.status == AppString.statusOrder.keys.elementAt(0) ||
              detailOrder.status == AppString.statusOrder.keys.elementAt(1)
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                backgroundColor: AppColors.mainColor1,
              ),
              onPressed: () {
                CustomeDialog.showCustomeDialog(
                    context: Get.context,
                    title: '',
                    message: 'Bạn có muốn nhận đơn không ???',
                    confirmText: 'Có',
                    pressConfirm: () {
                      orderShipperController.changeStatusOrder(detailOrder.id!);
                      Get.back();
                    });
              },
              child: Text('Xác nhận nhận đơn',
                  style: AppStyles.textSemiBold
                      .copyWith(color: AppColors.mainColorBackground)))
          : detailOrder.status == AppString.statusOrder.keys.elementAt(2)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    backgroundColor: AppColors.mainColor1,
                  ),
                  onPressed: () {
                    orderShipperController
                        .changeStatusOrder(detailOrder.id!)
                        .then((value) => CustomeSnackBar.showSuccessSnackTopBar(
                            context: Get.context,
                            title: 'Success',
                            message: 'Xác nhận đã nhận hàng'));
                  },
                  child: Text(
                    'Đã nhận hàng từ cửa hàng',
                    style: AppStyles.textSemiBold
                        .copyWith(color: AppColors.mainColorBackground),
                  ))
              : detailOrder.status == AppString.statusOrder.keys.elementAt(3)
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        backgroundColor: AppColors.mainColor1,
                      ),
                      onPressed: () {
                        orderShipperController
                            .changeStatusOrder(detailOrder.id!)
                            .then((value) =>
                                CustomeSnackBar.showSuccessSnackTopBar(
                                    context: Get.context,
                                    title: 'Success',
                                    message: 'Đã hoàn thành giao hàng'));
                      },
                      child: Text('Xác nhận đã giao hàng thành công',
                          style: AppStyles.textSemiBold
                              .copyWith(color: AppColors.mainColorBackground)))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        backgroundColor: AppColors.mainColor1,
                      ),
                      onPressed: () {
                        Get.offAndToNamed('/shipperNaviPage');
                        Get.find<ShipperController>().getListOrder();

                        // Get.offAllAndNamed('/shipperNaviPage');
                      },
                      child: Text('Tìm kiếm đơn khác',
                          style: AppStyles.textSemiBold
                              .copyWith(color: AppColors.mainColorBackground)));
    });
  }

  _orderDetail(List<Cart> carts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            'Đơn hàng',
            style: AppStyles.textMedium
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: isListShortened
              ? widthOrder.toDouble()
              : carts.length.toDouble() * widthOrder,
          child: ListView.builder(
            itemCount: carts.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              var cartProduct = carts[index];
              if (isListShortened && index >= 2) {
                return const SizedBox.shrink(); // Hide items beyond index 4
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  leading: ImageLoadingNetwork(
                      image: cartProduct.product.images[0],
                      size: const Size(60, 70)),
                  title: Text(
                    "${cartProduct.quantity} x ${cartProduct.product.name}",
                    style: AppStyles.textSmall
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  trailing: Text(
                    "${FuncUseful.formartStringPrice(cartProduct.price.toInt() * cartProduct.quantity.toInt())}đ",
                    style: AppStyles.textMedium
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          ),
        ),
        // Button to toggle list length
        carts.length > 1
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
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
  }
}
