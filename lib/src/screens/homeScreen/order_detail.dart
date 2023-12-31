import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/PlaceOrderController/place_order_controller.dart';
import 'package:pbl6_app/src/controller/StoreController/cart_controller.dart';
import 'package:pbl6_app/src/controller/UserController/ship_info_cart.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';
import 'package:pbl6_app/src/widgets/image_loading_network.dart';

import '../../controller/StoreController/store_detail_controller.dart';
import '../../controller/UserController/user_controller.dart';
import '../../helper/func/func_useful.dart';
import '../../widgets/food_cell_cart.dart';
import '../userScreen/list_contact.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int widthOrder = 90;

  var shipController = Get.put(ShippingFeeController());
  var userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    shipController.getInfoShip(userController.id.value,
        Get.find<StoreDetailController>().storeId.value);
  }

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppWidget.appBar("Xác nhận giao hàng"),
          // Address Section
          const Divider(
            height: 10,
            color: AppColors.placeholder,
            thickness: 10,
          ),

          _addressSection(),

          timeSection(),

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

  // done payment vnpay
  _orderOption(Size size) {
    var placeOrderController = Get.put(PlaceOrderController(
        shippingFeeController: Get.find(), cartController: Get.find()));
    return GetBuilder<PlaceOrderController>(builder: (_) {
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
                          color: placeOrderController.isVNPayOption
                              ? AppColors.mainColor1
                              : AppColors.borderGray)), // Set border color
                    ),
                    onPressed: () {
                      placeOrderController.changeOption(true);
                    },
                    child: Text(
                      "Chuyển khoản",
                      style: AppStyles.textMedium.copyWith(
                          color: placeOrderController.isVNPayOption
                              ? AppColors.mainColor1
                              : AppColors.borderGray,
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
                          color: placeOrderController.isVNPayOption
                              ? AppColors.borderGray
                              : AppColors.mainColor1)), // Set border color
                    ),
                    onPressed: () {
                      placeOrderController.changeOption(false);
                    },
                    child: Text(
                      "Tiền mặt",
                      style: AppStyles.textMedium.copyWith(
                          color: placeOrderController.isVNPayOption
                              ? AppColors.borderGray
                              : AppColors.mainColor1,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<ShippingFeeController>(builder: (_) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor1,
                  minimumSize: Size(size.width * 0.9, 55)),
              onPressed: () {
                var isVNPay = placeOrderController.isVNPayOption;
                if (isVNPay) {
                  placeOrderController.placeOrderWithVNPay().then((value) {
                    placeOrderController.onPayment(value);
                  });
                } else {
                  CustomeSnackBar.showMessageTopBar(
                      context: Get.context,
                      title: 'Thông báo',
                      message: 'Hiện tại chưa thể thanh toán bằng tiền mặt');
                }
              },
              child: Text(
                "Đặt đơn - ${FuncUseful.formartStringPrice(Get.find<CartController>().productTotal().toInt() + (shipController.currentInfo.shipCost ?? 0).toInt())}đ",
                style: AppStyles.textMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColorBackground),
              ),
            );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
  }

// order detai - done
  GetBuilder<CartController> _orderDetail() {
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
                      "${FuncUseful.formartStringPrice(cartProduct.price.toInt() * cartProduct.quantity)}đ",
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

//done
  _totalPaymentSection() {
    return GetBuilder<ShippingFeeController>(builder: (context) {
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
                Text(
                    "${FuncUseful.formartStringPrice(Get.find<CartController>().productTotal())}đ",
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
                Text(
                    "${FuncUseful.formartStringPrice((shipController.currentInfo.shipCost ?? 0))}đ",
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
                Text(
                    "${FuncUseful.formartStringPrice(Get.find<CartController>().productTotal().toInt() + (shipController.currentInfo.shipCost ?? 0).toInt())}đ",
                    style: AppStyles.textBold
                        .copyWith(fontSize: 15, color: AppColors.mainColor1)),
              ],
            ),
          ],
        ),
      );
    });
  }

  GetBuilder<UserController> _addressSection() {
    return GetBuilder<UserController>(
        // initState: (state) => userController.getInfoUserById(),
        builder: (_) {
      var user = userController.contacChoose;
      return Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.location_on,
                    color: AppColors.mainColor1,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Địa chỉ giao hàng",
                        style: AppStyles.textMedium.copyWith(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.address ?? ''.toString(),
                        style: AppStyles.textMedium.copyWith(fontSize: 15),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(user.phoneNumber ?? ''.toString(),
                          style: AppStyles.textMedium.copyWith(fontSize: 15)),
                    ],
                  ),
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const ListContactScreen());
                    },
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
          ],
        ),
      );
    });
  }

  GetBuilder<ShippingFeeController> timeSection() {
    return GetBuilder<ShippingFeeController>(
        initState: (state) => shipController.getInfoShip(
            userController.id.value,
            Get.find<StoreDetailController>().storeId.value),
        builder: (_) {
          return Container(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
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
                    "Dự kiến giao lúc ${shipController.getNowDelivery().toString()}",
                    style: AppStyles.textMedium.copyWith(fontSize: 15),
                  ),
                  Expanded(child: Container()),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
