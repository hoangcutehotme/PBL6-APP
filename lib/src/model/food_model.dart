// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pbl6_app/src/values/app_assets.dart';

class FoodModel {
  String id;
  String name;
  String categoryId;
  String nameCategory;
  String imageFood;
  double averageRating;
  String decription;
  double price;

  FoodModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.nameCategory,
    required this.imageFood,
    required this.averageRating,
    required this.decription,
    required this.price,
  });

  
  static List<FoodModel> getFoods() {
    List<FoodModel> listFood = [];

    listFood.add(FoodModel(
        id: "1",
        name: "Trà sữa Gongcha",
        categoryId: "1",
        imageFood: AppAssets.getImg("gongcha.png", "images"),
        averageRating: 4.6,
        decription: "Ngon nhứt nách",
        price: 30000,
        nameCategory: 'Đồ uống'));
    listFood.add(FoodModel(
        id: "2",
        name: "Ghẹ hấp 3 con",
        categoryId: "2",
        imageFood: AppAssets.getImg("ghe.jpg", "images"),
        averageRating: 4.0,
        decription: "Ngon nhứt nách",
        price: 103000,
        nameCategory: 'Đồ ăn'));
    listFood.add(FoodModel(
        id: "3",
        name: "Gà rán",
        categoryId: "2",
        imageFood: AppAssets.getImg("ga.jpg", "images"),
        averageRating: 4.7,
        decription: "Ngon tới từng miếng xương",
        price: 30000,
        nameCategory: 'Đồ ăn'));
    listFood.add(FoodModel(
        id: "4",
        name: "Nem nướng",
        categoryId: "2",
        imageFood: AppAssets.getImg("nemnuong.jpg", "images"),
        averageRating: 4.8,
        decription: "Zai zòn ngon ngon",
        price: 49000,
        nameCategory: 'Đồ ăn'));
    listFood.add(FoodModel(
        id: "5",
        name: "Bún đậu mắm tôm",
        categoryId: "2",
        imageFood: AppAssets.bundauImage,
        averageRating: 4.8,
        decription: "Ngon ngon",
        price: 49000,
        nameCategory: 'Đồ ăn'));

    return listFood;
  }
}
