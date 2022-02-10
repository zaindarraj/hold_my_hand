part of 'admin_bloc.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class Done extends AdminState {}

class Loading extends AdminState {}

class Error extends AdminState {
  String error;
  Error({required this.error});
}

class UserListReady extends AdminState {
  List<Map<dynamic, dynamic>> listOfUser;
  UserListReady({required this.listOfUser});
}

class BenefectorListReady extends AdminState {
  List<Map<dynamic, dynamic>> list;
  BenefectorListReady({required this.list});
}

//no users to approve
class NoUsers extends AdminState{}