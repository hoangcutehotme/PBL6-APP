import 'dart:convert';
import 'location_model.dart';

List<OrderShipper2> orderShipper2FromJson(String str) =>
    List<OrderShipper2>.from(
        json.decode(str).map((x) => OrderShipper2.fromJson(x)));

String orderShipper2ToJson(List<OrderShipper2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderShipper2 {
  LocationCoordinate? storeLocation;
  int? shipCost;
  int? totalPrice;
  String? status;
  String? id;
  String? user;
  Store? store;
  List<Cart>? cart;
  String? contact;
  DateTime? dateOrdered;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? dateCheckout;
  DateTime? datePrepared;
  Shipper2? shipper;

  OrderShipper2({
    this.storeLocation,
    this.shipCost,
    this.totalPrice,
    this.status,
    this.id,
    this.user,
    this.store,
    this.cart,
    this.contact,
    this.dateOrdered,
    this.createdAt,
    this.updatedAt,
    this.dateCheckout,
    this.datePrepared,
    this.shipper,
  });

  factory OrderShipper2.fromJson(Map<String, dynamic> json) => OrderShipper2(
        storeLocation: LocationCoordinate.fromJson(json["storeLocation"]),
        shipCost: json["shipCost"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        id: json["_id"],
        user: json["user"],
        store: Store.fromJson(json["store"]),
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        contact: json["contact"],
        dateOrdered: DateTime.parse(json["dateOrdered"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        dateCheckout: DateTime.parse(json["dateCheckout"]),
        datePrepared: DateTime.parse(json["datePrepared"]),
        shipper: Shipper2.fromJson(json["shipper"]),
      );

  Map<String, dynamic> toJson() => {
        "storeLocation": storeLocation?.toJson(),
        "shipCost": shipCost,
        "totalPrice": totalPrice,
        "status": status,
        "_id": id,
        "user": user,
        "store": store?.toJson(),
        "cart": List<dynamic>.from(cart ?? [].map((x) => x.toJson())),
        "contact": contact,
        "dateOrdered": dateOrdered?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "dateCheckout": dateCheckout?.toIso8601String(),
        "datePrepared": datePrepared?.toIso8601String(),
        "shipper": shipper?.toJson(),
      };
}

class Cart {
  int quantity;
  int price;
  String id;
  String product;
  String notes;

  Cart({
    required this.quantity,
    required this.price,
    required this.id,
    required this.product,
    required this.notes,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        quantity: json["quantity"],
        price: json["price"],
        id: json["_id"],
        product: json["product"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "price": price,
        "_id": id,
        "product": product,
        "notes": notes,
      };
}

class Shipper2 {
  String? photo;
  String? id;
  double? ratingAverage;
  String? firstName;
  String? lastName;
  String? shipperId;

  Shipper2({
    this.photo,
    this.id,
    this.ratingAverage,
    this.firstName,
    this.lastName,
    this.shipperId,
  });

  factory Shipper2.fromJson(Map<String, dynamic> json) => Shipper2(
        photo: json["photo"],
        id: json["_id"],
        ratingAverage: json["ratingAverage"].toDouble(),
        firstName: json["firstName"],
        lastName: json["lastName"],
        shipperId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "_id": id,
        "ratingAverage": ratingAverage,
        "firstName": firstName,
        "lastName": lastName,
        "id": shipperId,
      };
}

class Store {
  num? ratingsAverage;
  int? ratingsQuantity;
  String? id;
  int? ratingAverage;
  String? name;
  String? address;
  String? phoneNumber;
  String? image;
  String? storeId;

  Store({
    this.ratingsAverage,
    this.ratingsQuantity,
    this.id,
    this.ratingAverage,
    this.name,
    this.address,
    this.phoneNumber,
    this.image,
    this.storeId,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        ratingsAverage: json["ratingsAverage"],
        ratingsQuantity: json["ratingsQuantity"],
        id: json["_id"],
        ratingAverage: json["ratingAverage"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
        storeId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "ratingsAverage": ratingsAverage,
        "ratingsQuantity": ratingsQuantity,
        "_id": id,
        "ratingAverage": ratingAverage,
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "image": image,
        "id": storeId,
      };
}
