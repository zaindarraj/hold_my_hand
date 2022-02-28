part of 'order_food_bloc.dart';

@immutable
abstract class OrderFoodState {}

class OrderFoodInitial extends OrderFoodState {}

class Done extends OrderFoodState {}

class Error extends OrderFoodState {
  String errorMessage;
  Error({required this.errorMessage});
}
