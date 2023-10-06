import 'package:pbl6_app/src/model/food_model.dart';
import 'package:pbl6_app/src/values/app_assets.dart';

class StoreModel {
  String name;
  String id;
  String phonenumber;
  String address;
  String openAt;
  String closeAt;
  double distance;
  String decription;
  double ratingAverage;
  String image;
  List<FoodModel> listFood;
  StoreModel({
    required this.name,
    required this.id,
    required this.phonenumber,
    required this.address,
    required this.openAt,
    required this.closeAt,
    required this.distance,
    required this.decription,
    required this.ratingAverage,
    required this.image,
    required this.listFood,
  });

  // location to name address
  // fake data

  static List<StoreModel> getListStore() {
    List<StoreModel> listStore = [];

    listStore.add(StoreModel(
        name: "Bún đậu cô Tiên",
        id: "1",
        phonenumber: "0912312312",
        address: "51,Đặng Tất, Liên Chiểu, Đà Nẵng",
        openAt: '10:20',
        closeAt: "22:00",
        decription: "Ngon lắm ăn thử đi",
        ratingAverage: 4.7,
        image: AppAssets.bundauImage,
        listFood: [],
        distance: 1.5));

    listStore.add(StoreModel(
        name: "Jollibee - Phạm Như Xương",
        id: "2",
        phonenumber: "0912312334",
        address: "10 Phạm Như Xương, P. Hòa Khánh Nam, Đà Nẵng",
        openAt: '9:00',
        closeAt: "22:00",
        decription: "Ngon lắm ăn thử đi",
        ratingAverage: 4.7,
        image: AppAssets.jolibeImage,
        listFood: [],
        distance: 2.4));
    listStore.add(StoreModel(
        name: "Jollibee - Phạm Như Xương",
        id: "2",
        phonenumber: "0912312334",
        address: "10 Phạm Như Xương, P. Hòa Khánh Nam, Đà Nẵng",
        openAt: '9:00',
        closeAt: "22:00",
        decription: "Ngon lắm ăn thử đi",
        ratingAverage: 4.7,
        image: AppAssets.jolibeImage,
        listFood: [],
        distance: 2.4));
    listStore.add(StoreModel(
        name: "Jollibee - Phạm Như Xương",
        id: "2",
        phonenumber: "0912312334",
        address: "10 Phạm Như Xương, P. Hòa Khánh Nam, Đà Nẵng",
        openAt: '9:00',
        closeAt: "22:00",
        decription: "Ngon lắm ăn thử đi",
        ratingAverage: 4.7,
        image: AppAssets.jolibeImage,
        listFood: [],
        distance: 2.4));
    return listStore;
  }
}
