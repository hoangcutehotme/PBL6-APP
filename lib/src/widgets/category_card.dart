import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/food_category_model.dart';
import 'image_loading_network.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categorie,
  });

  final CategoryModel categorie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed("/detailcategory", arguments: categorie);
        },
        child: Column(
          children: [
            ImageLoadingNetwork(
              image: categorie.photo,
              size: const Size(120, 120),
            ),
            Text(categorie.catName)
          ],
        ),
      ),
    );
  }
}
