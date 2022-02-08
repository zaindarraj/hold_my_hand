part of 'registeration_bloc.dart';

abstract class RegisterationEvent {}

class CheckFlutterStorage extends RegisterationEvent {}

class CheckBio extends RegisterationEvent {}

class SignUp extends RegisterationEvent {
  String email;
  String password;
  String fName;
  String lName;
  String accountType;
  String? disabilityType;
  SignUp({
    required this.email,
    required this.password,
    required this.accountType,
    required this.fName,
    required this.lName,
    this.disabilityType,
  });
}

class SignIn extends RegisterationEvent {
  String email;
  String password;
  SignIn({required this.email, required this.password});
}

class SignOut extends RegisterationEvent {}

class SignInAdmin extends RegisterationEvent {
  String email;
  String password;
  SignInAdmin({required this.email, required this.password});
}
