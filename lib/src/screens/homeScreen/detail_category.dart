import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/ProductController/product_controller.dart';
import 'package:pbl6_app/src/model/temp.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

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
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Image.network(
              // product.images
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&q=80&w=3160&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace this URL with the actual URL of the image you want to load
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      color: AppColors.placeholder,
                      borderRadius: BorderRadius.circular(7)),
                  child: const Icon(Icons.error_outline),
                ); // Widget to display when the image fails to load
              },
            ),
          ),
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
    );
  }
}
