part of 'admin_bloc.dart';

abstract class AdminEvent {}


class DeleteBenefector extends AdminEvent {
  String email;
  DeleteBenefector({required this.email});
}

class AddBenefector extends AdminEvent {
  String email;
  String password;
  String fname;
  String lnamel;
  AddBenefector(
      {required this.email,
      required this.fname,
      required this.lnamel,
      required this.password});
}

class AddUser extends AdminEvent {
  String email;
  String password;
  String fname;
  String lnamel;
  String disablity;
  AddUser(
      {required this.email,
      required this.disablity,
      required this.fname,
      required this.lnamel,
      required this.password});
}


class GetCenters extends AdminEvent {}

class AddCenter extends AdminEvent {
  String name;
  AddCenter({required this.name});
}


class DeleteCenter extends AdminEvent {
  String centerID;
  DeleteCenter({required this.centerID});
}
