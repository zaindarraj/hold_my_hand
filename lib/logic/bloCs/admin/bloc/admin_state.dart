part of 'admin_bloc.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class Done extends AdminState {
  String message;
  Done({required this.message});
}

class Loading extends AdminState {}

class Error extends AdminState {
  String error;
  Error({required this.error});
}

class UserListReady extends AdminState {
  List<Map<dynamic, dynamic>> listOfUser;
  UserListReady({required this.listOfUser});
}

class BenefactorListReady extends AdminState {
  List<Map<dynamic, dynamic>> list;
  BenefactorListReady({required this.list});
}

//no users to approve
class NoUsers extends AdminState {}

class Centers extends AdminState {
  List<Map<dynamic, dynamic>> list;
  Centers({required this.list});
}
