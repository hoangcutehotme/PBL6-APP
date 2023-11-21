import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';

import '../controller/StoreController/cart_controller.dart';
import '../model/cart_model.dart';
import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';
import 'image_button.dart';
import 'image_loading_network.dart';

class FoodInfoCellCart extends StatelessWidget {
  const FoodInfoCellCart({
    super.key,
    required this.controller,
    required this.product,
    // required this.quantity,
  });
  final CartController controller;
  final CartModel product;

  // final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 115,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ImageLoadingNetwork(
                  image: product.images![0], size: const Size(100, 90))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppStyles.textMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  softWrap: true,
                ),
                TextButton(
                    onPressed: () {
                      TextEditingController noteController =
                          TextEditingController();
                      noteController.text = product.notes ?? '';
                      Get.bottomSheet(
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(15),
                                  //   topRight: Radius.circular(15),
                                  // ),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text('Thêm ghi chú',
                                          style: AppStyles.textMedium.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: TextButton(
                                          onPressed: () {
                                            CustomeSnackBar.showSuccessSnackTopBar(
                                                context: Get.context,
                                                title: 'Success',
                                                message:
                                                    'Cập nhật ghi chú thành công');
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            controller.updateNote(product.id,
                                                noteController.text);
                                          },
                                          child: Text(
                                            "Thêm",
                                            style: AppStyles.textMedium
                                                .copyWith(
                                                    color: AppColors.mainColor1,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: noteController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10),
                                      hintText: "Ghi chú cho quán",
                                      hintStyle: AppStyles.textMedium
                                          .copyWith(color: AppColors.grayBold),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: Text("Ghi chú",
                        style: AppStyles.textSmall
                            .copyWith(fontStyle: FontStyle.italic))),
                Row(
                  children: [
                    Text(
                      "${product.price.toInt()}đ",
                      style: AppStyles.textMedium.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainColor1),
                      maxLines: 1,
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ImageButton(
                        image: AppAssets.getImg("minus.png", "icons"),
                        press: () {
                          controller.removeCart(product.id);
                        },
                      ),
                    ),
                    Text(controller.products[product.id]?.quantity.toString() ??
                        '0'),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ImageButton(
                        image: AppAssets.getImg("plus.png", "icons"),
                        press: () {
                          controller.addCart(product.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
