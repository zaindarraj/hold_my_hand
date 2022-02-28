part of 'order_food_bloc.dart';

abstract class OrderFoodEvent {}

class OrderFood extends OrderFoodEvent {
  String email;
  String cardID;
  String password;
  List<String> order;
  OrderFood(
      {required this.cardID, required this.email, required this.password, required this.order});
}
