import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../model/food_model.dart';
import '../values/app_colors.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      // padding: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          // color: AppColors.mainColor1,
          // borderRadius: BorderRadius.circular(10),
          ),
      child: GestureDetector(
        onTap: () {
          //to detail view
          Get.toNamed("/detailshop");
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                food.imageFood,
                width: 160,
                height: 140,
                fit: BoxFit.fill,

                // color: AppColors.borderGray,
              ),
            ),
            Positioned(
              top: 130,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  "Freeship",
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
                "${food.price.toInt().toString()}đ",
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
