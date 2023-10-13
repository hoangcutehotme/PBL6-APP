// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pbl6_app/src/model/food_model.dart';

class OrderFood {
  FoodModel food;
  int amount;
  OrderFood({
    required this.food,
    required this.amount,
  });

  static List<OrderFood> getListOrderFood() {
    List<OrderFood> listOrderFood = [];
    listOrderFood.add(OrderFood(
      food: FoodModel.getFoods()[1],
      amount: 4,
    ));
    listOrderFood.add(OrderFood(
      food: FoodModel.getFoods()[4],
      amount: 2,
    ));
    listOrderFood.add(OrderFood(
      food: FoodModel.getFoods()[0],
      amount: 2,
    ));

    return listOrderFood;
  }
}
