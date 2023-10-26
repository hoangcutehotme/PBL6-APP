import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/food_category_model.dart';
import '../values/app_colors.dart';

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
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                categorie.photo,
                width: 120,
                height: 120,
                // loadingBuilder: (BuildContext context, Widget child,
                //     ImageChunkEvent? loadingProgress) {
                //   return const SizedBox(
                //     width: 120,
                //     height: 120,
                //     child: Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //   );
                // },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: AppColors.placeholder,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Icon(Icons.error_outline),
                  ); // Widget to display when the image fails to load
                },
              ),
            ),
            Text(categorie.catName)
          ],
        ),
      ),
    );
  }
}
