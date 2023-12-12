import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ProductController/product_controller.dart';

import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import 'package:pbl6_app/src/widgets/skelton.dart';

import '../../widgets/product_category_card.dart';

// ignore: must_be_immutable
class DetailCategory extends StatefulWidget {
  const DetailCategory({super.key});

  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  final ProductController _productController = Get.put(ProductController());
  var category = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.colorTextBold,
          backgroundColor: AppColors.mainColorBackground,
          shadowColor: Colors.transparent,
          title: Text(
            category.catName.toString(),
            style: AppStyles.textMedium
                .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        body: Center(
          child: Obx(() {
            if (_productController.isLoading.value) {
              return GridView.builder(
                padding: const EdgeInsets.only(
                    left: 7, top: 20, right: 7, bottom: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const Column(
                    children: [
                      Skelton(
                        width: 160,
                        height: 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Skelton(
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Skelton(
                        width: 100,
                      ),
                    ],
                  );
                },
              );
            } else if (_productController.list.isEmpty) {
              return const Text(
                  'No products available'); // Message when there are no products
            } else {
              return GridView.builder(
                padding: const EdgeInsets.only(
                    left: 7, top: 20, right: 7, bottom: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: _productController.list.length,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: _productController.list[index],
                    press: () {
                      Get.toNamed('/detailshop',
                          arguments: _productController.list[index].storeId);
                    },
                  );
                },
              );
            }
          }),
        ));
  }
}
