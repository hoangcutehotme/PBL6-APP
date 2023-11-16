// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pbl6_app/src/controller/StoreController/cart_controller.dart';
import 'package:pbl6_app/src/model/product_model.dart';
import 'package:pbl6_app/src/widgets/image_loading_network.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';
import 'image_button.dart';

class FoodInfoCell extends StatelessWidget {
  const FoodInfoCell({
    super.key,
    required this.controller,
    required this.product,
    // required this.quantity,
  });
  final CartController controller;
  final ProductModel product;
  // final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 140,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ImageLoadingNetwork(
                  image: product.images[0], size: const Size(160, 130))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppStyles.textMedium
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      "${product.price.toInt()}đ",
                      style: AppStyles.textMedium.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainColor1),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ImageButton(
                        image: AppAssets.getImg("minus.png", "icons"),
                        press: () {
                          print("remove");
                          controller.removeProduct(product);
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
                          print("Add");
                          controller.addProduct(product);
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
