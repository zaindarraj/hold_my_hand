part of 'registeration_bloc.dart';

abstract class RegisterationState {}

class RegisterationInitial extends RegisterationState {}




class Loading extends RegisterationState {}

class SignedIn extends RegisterationState {}


class ErrorState extends RegisterationState {
  String message;
  ErrorState({required this.message});
}
