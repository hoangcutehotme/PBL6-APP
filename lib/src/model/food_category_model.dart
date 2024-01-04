// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  String? id;
  String? catName;
  String? photo;

  CategoryModel({
    this.id,
    this.catName,
    this.photo,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        catName: json["catName"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() =>
      {"_id": id, "catName": catName, "photo": photo};
}
