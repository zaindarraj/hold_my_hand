part of 'admin_bloc.dart';

abstract class AdminEvent {}



class DeleteUser extends AdminEvent {
  String email;
  DeleteUser({required this.email});
}

class DeleteUser extends AdminEvent {
  String email;
  DeleteUser({required this.email});
}


class AddUser extends AdminEvent {
  String email;
  String password;
  String fname;
  String lnamel;
  String disablity;
  AddUser({required this.email, required this.disablity,required this.fname,required this.lnamel,required this.password});
}
