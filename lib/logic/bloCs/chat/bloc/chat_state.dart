part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class Error extends ChatState {
  String errorMessage;
  Error({required this.errorMessage});
}

class Messages extends ChatState {
  List<dynamic> list;
  Messages({required this.list});
}
