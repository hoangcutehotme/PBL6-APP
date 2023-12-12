import 'location_model.dart';

// class OrderDetailShipper {
//     String? id;
//     Location? storeLocation;
//     int? shipCost;
//     int? totalPrice;
//     String? status;
//     UserModel? user;
//     List<CartModel>? cart;
//     Contact? contact;
//     DateTime? dateOrdered;
//     StoreModel? store;
//     int? depreciationShip;
//     int? revenue;

//     OrderDetailShipper({
//         this.id,
//         this.storeLocation,
//         this.shipCost,
//         this.totalPrice,
//         this.status,
//         this.user,
//         this.cart,
//         this.contact,
//         this.dateOrdered,
//         this.store,
//         this.depreciationShip,
//         this.revenue,
//     });

//     factory OrderDetailShipper.fromJson(Map<String, dynamic> json) => OrderDetailShipper(
//         id: json["_id"],
//         storeLocation: Location.fromJson(json["storeLocation"]),
//         shipCost: json["shipCost"],
//         totalPrice: json["totalPrice"],
//         status: json["status"],
//         user: UserModel.fromJson(json["user"]),
//         cart: List<CartModel>.from(json["cart"].map((x) => CartModel.fromJson(x))),
//         contact: Contact.fromJson(json["contact"]),
//         dateOrdered: DateTime.parse(json["dateOrdered"]),
//         store: StoreModel.fromJson(json['store']),
//         depreciationShip: json["depreciationShip"],
//         revenue: json["revenue"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "storeLocation": storeLocation?.toJson(),
//         "shipCost": shipCost,
//         "totalPrice": totalPrice,
//         "status": status,
//         "user": user?.toJson(),
//         "cart": List<dynamic>.from(cart?? [].map((x) => x.toJson())),
//         "contact": contact?.toJson(),
//         "dateOrdered": dateOrdered?.toIso8601String(),
//         "store": store?.toJson(),
//         "depreciationShip": depreciationShip,
//         "revenue": revenue,
//     };
// }

class OrderDetailShipper {
  String? id;
  LocationCoordinate? storeLocation;
  int? shipCost;
  int? totalPrice;
  String? status;
  User? user;
  Store? store;
  List<Cart>? cart;
  Contact? contact;
  DateTime? dateOrdered;
  int? depreciationShip;
  int? revenue;
  DateTime? dateCheckout;
  DateTime? datePrepared;
  DateTime? dateDeliveried;
  DateTime? dateFinished;

  OrderDetailShipper({
    this.id,
    this.storeLocation,
    this.shipCost,
    this.totalPrice,
    this.status,
    this.user,
    this.store,
    this.cart,
    this.contact,
    this.dateOrdered,
    this.depreciationShip,
    this.revenue,
    this.dateCheckout,
    this.datePrepared,
    this.dateDeliveried,
    this.dateFinished,
  });

  factory OrderDetailShipper.fromJson(Map<String, dynamic> json) =>
      OrderDetailShipper(
        id: json["_id"],
        storeLocation: LocationCoordinate.fromJson(json["storeLocation"]),
        shipCost: json["shipCost"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        user: User.fromJson(json["user"]),
        store: Store.fromJson(json["store"]),
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        contact: Contact.fromJson(json["contact"]),
        dateOrdered: DateTime.parse(json["dateOrdered"]),
        depreciationShip: json["depreciationShip"],
        revenue: json["revenue"],
        dateCheckout: json["dateCheckout"] == null
            ? null
            : DateTime.parse(json["dateCheckout"]),
        datePrepared: json["datePrepared"] == null
            ? null
            : DateTime.parse(json["datePrepared"]),
        dateDeliveried: json["dateDeliveried"] == null
            ? null
            : DateTime.parse(json["dateDeliveried"]),
        dateFinished: json["dateFinished"] == null
            ? null
            : DateTime.parse(json["dateFinished"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "storeLocation": storeLocation?.toJson(),
        "shipCost": shipCost,
        "totalPrice": totalPrice,
        "status": status,
        "user": user?.toJson(),
        "store": store?.toJson(),
        "cart": List<dynamic>.from(cart ?? [].map((x) => x.toJson())),
        "contact": contact?.toJson(),
        "dateOrdered": dateOrdered?.toIso8601String(),
        "depreciationShip": depreciationShip,
        "revenue": revenue,
      };
}

class Cart {
  int quantity;
  int price;
  String id;
  Product product;
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
        product: Product.fromJson(json["product"]),
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "price": price,
        "_id": id,
        "product": product.toJson(),
        "notes": notes,
      };
}

class Product {
  String name;
  String id;
  List<String> images;

  Product({
    required this.name,
    required this.id,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "images": List<dynamic>.from((images).map((x) => x)),
      };
}

class Contact {
  String? id;
  Location? location;
  String? address;
  String? phoneNumber;

  Contact({
    this.id,
    this.location,
    this.address,
    this.phoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        location: Location.fromJson(json["location"]),
        address: json["address"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location": location?.toJson(),
        "address": address,
        "phoneNumber": phoneNumber,
      };
}

class Store {
  String? id;
  String? address;
  String? name;
  String? image;

  Store({
    this.id,
    this.address,
    this.name,
    this.image,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        address: json["address"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "name": name,
        "image": image,
      };
}

// class StoreLocation {
//     List<double> coordinates;

//     StoreLocation({
//         this.coordinates,
//     });

//     factory StoreLocation.fromJson(Map<String, dynamic> json) => StoreLocation(
//         coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
//     );

//     Map<String, dynamic> toJson() => {
//         "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
//     };
// }

class User {
  String? firstName;
  String? lastName;
  String? email;

  User({
    this.firstName,
    this.lastName,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}
