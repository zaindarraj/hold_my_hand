part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  int senderID;
  int receiverID;
  String message;
  SendMessage(
      {required this.senderID,
      required this.message,
      required this.receiverID});
}


class ReadMessages extends ChatEvent {
  int senderID;
  int receiverID;
  ReadMessages({required this.receiverID, required this.senderID});
}
