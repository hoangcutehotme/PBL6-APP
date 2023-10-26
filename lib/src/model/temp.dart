import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  Category category;
  int price;
  int ratingAverage;
  bool isOutofOrder;
  String id;
  String name;
  String images;
  String description;
  String storeId;
  int v;
  // bool isFavoured;

  ProductModel({
    required this.category,
    required this.price,
    required this.ratingAverage,
    required this.isOutofOrder,
    required this.id,
    required this.name,
    required this.images,
    required this.description,
    required this.storeId,
    required this.v,
    // required this.isFavoured,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        category: Category.fromJson(json["category"]),
        price: json["price"],
        ratingAverage: json["ratingAverage"],
        isOutofOrder: json["isOutofOrder"],
        id: json["_id"],
        name: json["name"],
        images: json["images"],
        description: json["description"],
        storeId: json["storeId"],
        v: json["__v"],
        // isFavoured: json["isFavoured"],
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "price": price,
        "ratingAverage": ratingAverage,
        "isOutofOrder": isOutofOrder,
        "_id": id,
        "name": name,
        "images": images,
        "description": description,
        "storeId": storeId,
        "__v": v,
        // "isFavoured": isFavoured,
      };
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
