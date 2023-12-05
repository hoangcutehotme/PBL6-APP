import 'dart:convert';

List<ProductModel> productsModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));
// List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
//     json.decode(str).map((x) => ProductModel.fromJson(x)));
String producModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  Category? category;
  List<String>? images;
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
    this.images,
    required this.price,
    this.ratingAverage,
    this.isOutofOrder,
    required this.id,
    required this.name,
    required this.description,
    this.storeId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
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
        "images": List<dynamic>.from(images ?? [].map((x) => x)),
        "price": price,
        "ratingAverage": ratingAverage,
        "isOutofOrder": isOutofOrder,
        "_id": id,
        "name": name,
        "description": description,
        "storeId": storeId,
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
