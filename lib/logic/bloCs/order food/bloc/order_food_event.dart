part of 'order_food_bloc.dart';

abstract class OrderFoodEvent {}

class OrderFood extends OrderFoodEvent {
  String userID;
  String cardID;
  List<String> order;
  OrderFood(
      {required this.cardID, required this.userID,
       required this.order});
}
