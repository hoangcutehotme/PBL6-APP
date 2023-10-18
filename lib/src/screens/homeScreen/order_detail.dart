import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/food_model.dart';
import 'package:pbl6_app/src/model/order_model.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../../model/order_food_model.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  OrderModel? orderDetail;
  int widthOrder = 90;
  bool chooseCash = true;

  @override
  void initState() {
    orderDetail = OrderModel.getOrder();
    check(orderDetail!.listOrder);
    super.initState();
  }

  // Boolean flag to indicate whether the list is shortened or not
  bool isListShortened = true;
  bool showFull = false;

  // Function to toggle list length
  void toggleListLength() {
    setState(() {
      isListShortened = !isListShortened;
    });
  }

  // check list order
  void check(List<OrderFood> listfood) {
    if (listfood.length > 1) {
      setState(() {
        showFull = true;
      });
    }
  }

  void changeOptionPayment(String option) {
    setState(() {
      chooseCash = option == "cash" ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _appBar(),
          // Address Section
          const Divider(
            height: 10,
            color: AppColors.placeholder,
            thickness: 10,
          ),

          _addressAndTimeSection(orderDetail!),

          const Divider(
            height: 10,
            color: AppColors.placeholder,
            thickness: 10,
          ),
          // Order Section
          _orderDetail(),
          const Divider(
            height: 10,
            color: AppColors.placeholder,
            thickness: 10,
          ),
          //Total payment
          _totalPaymentSection(),
          // Order Option
          const Divider(
            height: 10,
            color: AppColors.placeholder,
            thickness: 10,
          ),
          _orderOption(size),
        ]),
      ),
    );
  }

  Column _orderOption(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 170,
              height: 50,
              child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(
                        width: 1.5,
                        color: chooseCash
                            ? AppColors.borderGray
                            : AppColors.mainColor1)), // Set border color
                  ),
                  onPressed: () {
                    changeOptionPayment("tranfer");
                  },
                  child: Text(
                    "Chuyển khoản",
                    style: AppStyles.textMedium.copyWith(
                        color: chooseCash
                            ? AppColors.borderGray
                            : AppColors.mainColor1,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(
              width: 170,
              height: 50,
              child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(
                        width: 1.5,
                        color: chooseCash
                            ? AppColors.mainColor1
                            : AppColors.borderGray)), // Set border color
                  ),
                  onPressed: () {
                    changeOptionPayment("cash");
                  },
                  child: Text(
                    "Tiền mặt",
                    style: AppStyles.textMedium.copyWith(
                        color: chooseCash
                            ? AppColors.mainColor1
                            : AppColors.borderGray,
                        fontWeight: FontWeight.w500),
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor1,
              minimumSize: Size(size.width * 0.9, 55)),
          onPressed: () {
            Get.toNamed("/ordersuccess");
          },
          child: Text(
            "Đặt đơn - ${orderDetail!.totalAmount.toInt() + 15000}đ",
            style: AppStyles.textMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.mainColorBackground),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Padding _totalPaymentSection() {
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
              Text("${orderDetail!.totalAmount.toInt()}đ",
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
              Text("15000đ",
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
              Text("${orderDetail!.totalAmount.toInt() + 15000}đ",
                  style: AppStyles.textBold
                      .copyWith(fontSize: 15, color: AppColors.mainColor1)),
            ],
          ),
        ],
      ),
    );
  }

  Column _orderDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            orderDetail!.nameStore,
            style: AppStyles.textMedium
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: isListShortened
              ? widthOrder.toDouble()
              : orderDetail!.listOrder.length.toDouble() * widthOrder,
          child: ListView.builder(
            itemCount: orderDetail?.listOrder.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              OrderFood orderfood = orderDetail!.listOrder[index];
              if (isListShortened && index >= 2) {
                return const SizedBox.shrink(); // Hide items beyond index 4
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.asset(
                    orderfood.food.imageFood,
                    width: 60,
                    height: 70,
                  ),
                  title: Text(
                    "${orderfood.amount} x ${orderfood.food.name}",
                    style: AppStyles.textSmall
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  trailing: Text(
                    "${orderfood.food.price.toInt() * orderfood.amount}đ",
                    style: AppStyles.textMedium
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          ),
        ),
        // Button to toggle list length
        showFull
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
  }

  Container _addressAndTimeSection(OrderModel order) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.location_on,
                  color: AppColors.mainColor1,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ giao hàng",
                    style: AppStyles.textMedium.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(order.address,
                      style: AppStyles.textMedium.copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("0912384564",
                      style: AppStyles.textMedium.copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Expanded(child: Container()),
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 10,
            color: AppColors.borderGray,
          ),
          Container(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12, left: 3),
                    child: Icon(
                      Icons.access_time_rounded,
                      color: AppColors.mainColor1,
                      size: 20,
                    ),
                  ),
                  Text(
                    "Dự kiến giao lúc 10:30 16/10",
                    style: AppStyles.textMedium.copyWith(fontSize: 16),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    foregroundColor: AppColors.mainColor1,
    backgroundColor: AppColors.mainColorBackground,
    shadowColor: Colors.transparent,
    title: Text(
      "Xác nhận giao hàng",
      style: AppStyles.textBold
          .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
    ),
  );
}
