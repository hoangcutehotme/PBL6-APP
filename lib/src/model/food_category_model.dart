// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  String id;
  String catName;
  String photo;

  CategoryModel({
    required this.id,
    required this.catName,
    required this.photo,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        catName: json["catName"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() =>
      {"_id": id, "catName": catName, "photo": photo};
}

//   // static List<CategoryModel> getCategories() {
//   //   List<CategoryModel> categories = [];

//   //   categories.add(CategoryModel(name: 'Đồ ăn', imgPath: AppAssets.foodImage, id: ''));
//   //   categories
//   //       .add(CategoryModel(name: 'Đồ uống', imgPath: AppAssets.milkteaImage, id: ''));

//   //   categories
//   //       .add(CategoryModel(name: 'Đồ ăn nhanh', imgPath: AppAssets.foodImage, id: ''));
//   //   categories
//   //       .add(CategoryModel(name: 'Đồ chay', imgPath: AppAssets.foodImage, id: ''));

//   //   return categories;
//   // }
