//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) =>
    List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
  double ratingAverage;
  String images;
  bool isLocked;
  String id;
  String name;
  String? phoneNumber;
  String address;
  String openAt;
  String closeAt;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  String? ownerId;
  // String? registrationLicense;

  StoreModel({
    required this.ratingAverage,
    required this.images,
    required this.isLocked,
    required this.id,
    required this.name,
    this.phoneNumber,
    required this.address,
    required this.openAt,
    required this.closeAt,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.ownerId,
    // this.registrationLicense,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        ratingAverage: json["ratingAverage"]?.toDouble(),
        images: json["images"],
        isLocked: json["isLocked"],
        id: json["_id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        openAt: json["openAt"],
        closeAt: json["closeAt"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        ownerId: json["ownerId"],
        // registrationLicense: json["registrationLicense"],
      );

  Map<String, dynamic> toJson() => {
        "ratingAverage": ratingAverage,
        "images": images,
        "isLocked": isLocked,
        "_id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "openAt": openAt,
        "closeAt": closeAt,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ownerId": ownerId,
        // "registrationLicense": registrationLicense,
      };

  // static List<StoreModel> getListStore() {
//     List<StoreModel> listStore = [];
//     List<FoodModel> listFood1 = FoodModel.getFoods();

//     listStore.add(StoreModel(
//         name: "Bún đậu cô Tiên",
//         id: "1",
//         phonenumber: "0912312312",
//         address: "51,Đặng Tất, Liên Chiểu, Đà Nẵng",
//         openAt: '10:20',
//         closeAt: "22:00",
//         decription: "Ngon lắm ăn thử đi",
//         ratingAverage: 4.7,
//         image: AppAssets.bundauImage,
//         listFood: listFood1,
//         distance: 1.5));

//     listStore.add(StoreModel(
//         name: "Jollibee - Phạm Như Xương",
//         id: "2",
//         phonenumber: "0912312334",
//         address: "10 Phạm Như Xương, P. Hòa Khánh Nam, Đà Nẵng",
//         openAt: '9:00',
//         closeAt: "22:00",
//         decription: "Ngon lắm ăn thử đi",
//         ratingAverage: 4.7,
//         image: AppAssets.jolibeImage,
//         listFood: [],
//         distance: 2.4));
//     listStore.add(StoreModel(
//         name: "Jollibee - Phạm Như Xương",
//         id: "2",
//         phonenumber: "0912312334",
//         address: "10 Phạm Như Xương, P. Hòa Khánh Nam, Đà Nẵng",
//         openAt: '9:00',
//         closeAt: "22:00",
//         decription: "Ngon lắm ăn thử đi",
//         ratingAverage: 4.7,
//         image: AppAssets.jolibeImage,
//         listFood: [],
//         distance: 2.4));
//     listStore.add(StoreModel(
//         name: "Jollibee - Phạm Như Xương",
//         id: "2",
//         phonenumber: "0912312334",
//         address: "10 Phạm Như Xương, P. Hòa Khánh Nam, Đà Nẵng",
//         openAt: '9:00',
//         closeAt: "22:00",
//         decription: "Ngon lắm ăn thử đi",
//         ratingAverage: 4.7,
//         image: AppAssets.jolibeImage,
//         listFood: [],
//         distance: 2.4));
//     return listStore;
//   }
}


// class StoreModel {
//   String name;
//   String id;
//   String phonenumber;
//   String address;
//   String openAt;
//   String closeAt;
//   double distance;
//   String decription;
//   double ratingAverage;
//   String image;
//   List<FoodModel> listFood;

  

//   StoreModel({
//     required this.name,
//     required this.id,
//     required this.phonenumber,
//     required this.address,
//     required this.openAt,
//     required this.closeAt,
//     required this.distance,
//     required this.decription,
//     required this.ratingAverage,
//     required this.image,
//     required this.listFood,
//   });

//   // location to name address
//   // fake data

// 
// }
