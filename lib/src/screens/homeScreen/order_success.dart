import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/OrderController/order_change_stepper.dart';
import '../../helper/func/func_useful.dart';
import '../../model/order_detail_shipper.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import '../../widgets/image_loading_network.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  int widthOrder = 90;

  bool isListShortened = true;
  bool showFull = false;

  var orderId = Get.arguments;

  ChangeStepperOrder changeStepperOrder =
      Get.put(ChangeStepperOrder(orderRepo: Get.find()));

  // Function to toggle list length
  void toggleListLength() {
    setState(() {
      isListShortened = !isListShortened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _appBar(),
            orderId.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _listStatusOrder(context, changeStepperOrder, Get.arguments),
          ],
        ),
      ),
    );
  }

  Theme _listStatusOrder(BuildContext context,
      ChangeStepperOrder changeStepperOrder, String orderId) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.mainColor1)),
      child: GetBuilder<ChangeStepperOrder>(
          initState: (state) => changeStepperOrder.getStep(orderId),
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
                        margin: const EdgeInsets.all(10),
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
                      // show order
                      _totalPaymentSection(changeStepperOrder.order),
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
                  padding: EdgeInsets.zero,
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

AppBar _appBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text("Thông tin đơn hàng"),
    foregroundColor: AppColors.mainColor1,
    backgroundColor: AppColors.mainColorBackground,
    shadowColor: Colors.transparent,
    actions: [
      IconButton(
        icon: const Icon(Icons.home_filled),
        onPressed: () {
          Get.offAllNamed("/home");
        },
      ),
    ],
    // leading: Container()
  );
}
