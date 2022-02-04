part of 'registeration_bloc.dart';

abstract class RegisterationEvent {}

class CheckFlutterStorage extends RegisterationEvent {}

class CheckBio extends RegisterationEvent {}

class SignUp extends RegisterationEvent {
  String email;
  String password;
  String state;
  SignUp({required this.email, required this.password, required this.state});
}
