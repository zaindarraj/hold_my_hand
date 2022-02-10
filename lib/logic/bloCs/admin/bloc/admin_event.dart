part of 'admin_bloc.dart';

abstract class AdminEvent {}

class DeleteUser extends AdminEvent {
  String email;
  DeleteUser({required this.email});
}

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

class GetUsersList extends AdminEvent {}
class GetBenefectorList extends AdminEvent {}
class ApproveBenefector extends AdminEvent {
  String email;
  ApproveBenefector({required this.email});
}
class ApproveUser extends AdminEvent {
  String email;
  ApproveUser({required this.email});
}
