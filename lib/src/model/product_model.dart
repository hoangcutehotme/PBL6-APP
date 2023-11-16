import 'dart:convert';

import '../values/app_assets.dart';

List<ProductModel> productsModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));
// List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
//     json.decode(str).map((x) => ProductModel.fromJson(x)));
String producModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  Category? category;
  List<String> images;
  int price;
  int? ratingAverage;
  bool? isOutofOrder;
  String id;
  String name;
  String description;
  String? storeId;
  int? v;

  ProductModel({
    this.category,
    required this.images,
    required this.price,
    this.ratingAverage,
    this.isOutofOrder,
    required this.id,
    required this.name,
    required this.description,
    this.storeId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        category: Category.fromJson(json["category"]),
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        ratingAverage: json["ratingAverage"],
        isOutofOrder: json["isOutofOrder"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        storeId: json["storeId"],
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "price": price,
        "ratingAverage": ratingAverage,
        "isOutofOrder": isOutofOrder,
        "_id": id,
        "name": name,
        "description": description,
        "storeId": storeId,
      };

  static List<ProductModel> getFoods() {
    List<ProductModel> listFood = [];

    listFood.add(ProductModel(
      id: "1",
      name: "Trà sữa Gongcha",
      images: [AppAssets.getImg("gongcha.png", "images")],
      ratingAverage: 4,
      description: "Ngon nhứt nách",
      price: 30000,
    ));
    listFood.add(ProductModel(
      id: "2",
      name: "Ghẹ hấp 3 con",
      images: [AppAssets.getImg("ghe.jpg", "images")],
      ratingAverage: 4,
      description: "Ngon nhứt nách",
      price: 103000,
    ));
    listFood.add(ProductModel(
      id: "3",
      name: "Gà rán",
      images: [AppAssets.getImg("ga.jpg", "images")],
      ratingAverage: 4,
      description: "Ngon tới từng miếng xương",
      price: 30000,
    ));
    listFood.add(ProductModel(
      id: "4",
      name: "Nem nướng",
      images: [AppAssets.getImg("nemnuong.jpg", "images")],
      ratingAverage: 4,
      description: "Zai zòn ngon ngon",
      price: 49000,
    ));
    // listFood.add(ProductModel(
    //     id: "5",
    //     name: "Bún đậu mắm tôm",
    //     categoryId: "2",
    //     imageFood: AppAssets.bundauImage,
    //     averageRating: 4.8,
    //     decription: "Ngon ngon",
    //     price: 49000,
    //     nameCategory: 'Đồ ăn'));

    return listFood;
  }
}

class Category {
  String catName;
  Category({
    required this.catName,
  });
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catName: json["catName"],
      );

  Map<String, dynamic> toJson() => {
        "catName": catName,
      };
}
