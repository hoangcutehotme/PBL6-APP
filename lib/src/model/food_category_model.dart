// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:pbl6_app/src/values/app_assets.dart';

// List<CategoryModel> categoryModelFromJson(String str) =>
//     List<CategoryModel>.from(
//         json.decode(str).map((x) => CategoryModel.fromJson(x)));

// String categoryModelToJson(List<CategoryModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  String id;
  String catName;

  CategoryModel({
    required this.id,
    required this.catName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        catName: json["catName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "catName": catName,
      };
}

// class CategoryModel {
//   String id;
//   String name;
//   // String? imgPath;

//   CategoryModel({
//     required this.id,
//     required this.name,
//     // this.imgPath,
//   });

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

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       // 'imgPath': imgPath,
//     };
//   }

//   factory CategoryModel.fromMap(Map<String, dynamic> map) {
//     return CategoryModel(
//       id: map['_id'] as String,
//       name: map['name'] as String,
//       // imgPath: map['imgPath'] != null ? map['imgPath'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CategoryModel.fromJson(String source) =>
//       CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
