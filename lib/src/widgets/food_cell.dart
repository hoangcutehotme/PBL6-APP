// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../model/food_model.dart';
import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';
import 'image_button.dart';

class FoodInfoCell extends StatelessWidget {
  const FoodInfoCell({
    Key? key,
    required this.food,
    required this.pressPlus,
    required this.pressMinus,
    required this.count,
  }) : super(key: key);

  final FoodModel food;
  final Function() pressPlus;
  final Function() pressMinus;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 140,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              food.imageFood,
              width: 160,
              height: 130,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: AppStyles.textMedium
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  "52 đã bán",
                  style: AppStyles.textMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.borderGray),
                ),
                Row(
                  children: [
                    Text(
                      "${food.price.toInt()}đ",
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
                        press: pressMinus,
                      ),
                    ),
                    Text(count.toString()),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ImageButton(
                        image: AppAssets.getImg("plus.png", "icons"),
                        press: pressPlus,
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
