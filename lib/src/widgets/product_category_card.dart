
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';
import 'image_loading_network.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final Function() press;

  const ProductWidget({super.key, required this.product, required this.press});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GestureDetector(
        onTap: press,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageLoadingNetwork(
                image: product.images == null ? "" : product.images![0],
                size: const Size(160, 160)),
            Text(
              product.name,
              style: AppStyles.textMedium.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "${product.price}đ",
              style: AppStyles.textMedium.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.mainColor1),
            ),
          ],
        ),
      ),
    );
  }
}
