import 'package:pbl6_app/src/values/app_assets.dart';

class CategoryModel {
  String name;
  String imgPath;

  CategoryModel({
    required this.name,
    required this.imgPath,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    
    categories.add(CategoryModel(name: 'Đồ ăn', imgPath: AppAssets.foodImage));
    categories
        .add(CategoryModel(name: 'Đồ uống', imgPath: AppAssets.milkteaImage));

    categories
        .add(CategoryModel(name: 'Đồ ăn nhanh', imgPath: AppAssets.foodImage));
    categories
        .add(CategoryModel(name: 'Đồ chay', imgPath: AppAssets.foodImage));

    return categories;
  }

  
}
