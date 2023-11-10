import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ProductController/product_controller.dart';
import 'package:pbl6_app/src/model/product_model.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';
import 'package:pbl6_app/src/widgets/image_loading_network.dart';

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
              return const CircularProgressIndicator(); // Loading indicator while data is being fetched
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
                    press: () {},
                  );
                },
              );
            }
          }),
        ));
  }
}

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
                image: product.images.isEmpty ? "" : product.images[0],
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
