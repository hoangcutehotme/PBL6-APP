import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/model/product_model.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import '../helper/func/func_useful.dart';
import '../values/app_colors.dart';
import 'image_loading_network.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final ProductModel food;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: GestureDetector(
        onTap: () {
          //to detail view
          Get.toNamed("/detailshop", arguments: food.storeId);
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ImageLoadingNetwork(
                image: food.images == null ? '' : food.images![0],
                size: const Size(160, 140)),
            Positioned(
              top: 130,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  "Deal hời",
                  style: AppStyles.textBold.copyWith(fontSize: 14),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 10,
              child: Text(
                food.name,
                maxLines: 1,
                style: AppStyles.textBold.copyWith(fontSize: 16),
              ),
            ),
            Positioned(
              top: 175,
              child: Text(
                "${FuncUseful.formartStringPrice(food.price.toInt())}đ",
                style: AppStyles.textBold
                    .copyWith(fontSize: 16, color: AppColors.mainColor1),
                // textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
