part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class Done extends AdminState {}

class Loading extends AdminState {}

class Error extends AdminState {
  String error;
  Error({required this.error});
}
