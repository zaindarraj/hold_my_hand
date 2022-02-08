part of 'registeration_bloc.dart';

abstract class RegisterationState {}

class RegisterationInitial extends RegisterationState {}

class Loading extends RegisterationState {}

class Done extends RegisterationState {}

class SignedIn extends RegisterationState {
  String? accountType;
  SignedIn({this.accountType});
}


class ErrorState extends RegisterationState {
  String message;
  ErrorState({required this.message});
}
