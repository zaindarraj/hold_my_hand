part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  String senderID;
  String receiverID;
  String message;
  SendMessage(
      {required this.senderID,
      required this.message,
      required this.receiverID});
}





class ReadMessages extends ChatEvent {
  String senderID;
  String receiverID;
  ReadMessages({required this.receiverID, required this.senderID});
}
