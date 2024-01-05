import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/order_detail_shipper.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import '../../controller/OrderController/order_change_stepper.dart';
import '../../helper/func/func_useful.dart';
import '../../values/app_styles.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/image_loading_network.dart';

class OrderInfoScreen extends StatefulWidget {
  final String id;
  const OrderInfoScreen({super.key, required this.id});

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  int widthOrder = 90;

  bool isListShortened = true;
  bool showFull = false;

  // Function to toggle list length
  void toggleListLength() {
    setState(() {
      isListShortened = !isListShortened;
    });
  }

  @override
  Widget build(BuildContext context) {
    ChangeStepperOrder changeStepperOrder =
        Get.put(ChangeStepperOrder(orderRepo: Get.find()));
    return Scaffold(
      appBar: AppWidget.appBar('Thông tin đơn hàng'),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _listStatusOrder(context, changeStepperOrder),
        ]),
      ),
    );
  }

  Theme _listStatusOrder(
      BuildContext context, ChangeStepperOrder changeStepperOrder) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.mainColor1)),
      child: GetBuilder<ChangeStepperOrder>(
          initState: (state) => changeStepperOrder.getStep(widget.id),
          builder: (_) {
            var steps = changeStepperOrder.listStep;
            var currentStep = changeStepperOrder.currentStep;
            var order = changeStepperOrder.order;
            return steps.isEmpty || order.id == null
                ? const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // status order
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              'Trạng thái',
                              style: AppStyles.textMedium.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(FuncUseful.formatStatus(order.status),
                                style: AppStyles.textMedium.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        FuncUseful.colorStatus(order.status)))
                          ],
                        ),
                      ),
                      // stepper
                      Stepper(
                        steps: changeStepperOrder.listStep,
                        controlsBuilder: (context, details) {
                          return Container();
                        },
                        currentStep: currentStep,
                      ),
                      // list cart order
                      _orderDetail(
                        changeStepperOrder.order,
                      ),
                      _totalPaymentSection(changeStepperOrder.order),
                      // show order
                    ],
                  );
          }),
    );
  }

  _totalPaymentSection(OrderDetailShipper order) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Tổng cộng món",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500)),
              Expanded(child: Container()),
              Text("${FuncUseful.formartStringPrice(order.totalCart())}đ",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 20,
            color: AppColors.borderGray,
          ),
          Row(
            children: [
              Text("Phí giao hàng",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500)),
              Expanded(child: Container()),
              Text("${FuncUseful.formartStringPrice(order.shipCost)}đ",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 20,
            color: AppColors.borderGray,
          ),
          Row(
            children: [
              Text("Giảm giá",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500)),
              Expanded(child: Container()),
              Text(
                  "-${FuncUseful.formartStringPrice((order.totalCart() + order.shipCost!.toInt() - order.totalPrice!.toInt()))}đ",
                  style: AppStyles.textMedium
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 20,
            color: AppColors.borderGray,
          ),
          Row(
            children: [
              Text(
                "Tộng cộng",
                style: AppStyles.textBold.copyWith(fontSize: 16),
              ),
              Expanded(child: Container()),
              Text("${FuncUseful.formartStringPrice(order.totalPrice)}đ",
                  style: AppStyles.textBold
                      .copyWith(fontSize: 15, color: AppColors.mainColor1)),
            ],
          ),
        ],
      ),
    );
  }

  _orderDetail(OrderDetailShipper order) {
    return order.id == null
        ? const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  order.store?.name ?? '',
                  style: AppStyles.textMedium
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              AnimatedContainer(
                padding: EdgeInsets.zero,
                duration: const Duration(milliseconds: 100),
                height: isListShortened
                    ? widthOrder.toDouble()
                    : order.cart!.length.toDouble() * widthOrder,
                child: ListView.builder(
                  itemCount: order.cart!.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    var cartProduct = order.cart!.elementAt(index);
                    if (isListShortened && index >= 2) {
                      return const SizedBox
                          .shrink(); // Hide items beyond index 4
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: ImageLoadingNetwork(
                            image: cartProduct.product.images[0],
                            size: const Size(60, 70)),
                        title: Text(
                          "${cartProduct.quantity} x ${cartProduct.product.name}",
                          style: AppStyles.textSmall.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          "${FuncUseful.formartStringPrice(cartProduct.price.toInt() * cartProduct.quantity)}đ",
                          style: AppStyles.textMedium.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Button to toggle list length
              order.cart!.length > 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: TextButton(
                            onPressed: toggleListLength,
                            child:
                                Text(isListShortened ? 'Xem thêm' : 'Thu gọn'),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          );
  }
}
