class CartModel {
  List<String>? images;
  int price;
  String id;
  String name;
  String storeId;
  int quantity = 0;
  String? notes = '';

  CartModel({
    this.images,
    required this.price,
    required this.id,
    required this.name,
    required this.storeId,
    required this.quantity,
    this.notes,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        id: json["_id"],
        name: json["name"],
        storeId: json["storeId"],
        quantity: json["quantity"],
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images!.map((x) => x)),
        "price": price,
        "_id": id,
        "name": name,
        "storeId": storeId,
        "quantity": quantity,
        "notes": notes
      };
}

