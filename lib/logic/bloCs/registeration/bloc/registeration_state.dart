part of 'registeration_bloc.dart';

abstract class RegisterationState {}

class RegisterationInitial extends RegisterationState {}

class Loading extends RegisterationState {}

class Done extends RegisterationState {}
class Admin extends RegisterationState{}
class User extends RegisterationState {
  Map<String, dynamic> data;
  User({required this.data});
}

class Benefector extends RegisterationState {
  Map<String, dynamic> data;
  Benefector({required this.data});
}

class ErrorState extends RegisterationState {
  String message;
  ErrorState({required this.message});
}
