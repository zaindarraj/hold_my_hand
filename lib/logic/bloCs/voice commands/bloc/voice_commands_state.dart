part of 'voice_commands_bloc.dart';

abstract class VoiceCommandsState {}

class VoiceCommandsInitial extends VoiceCommandsState {}

class Error extends VoiceCommandsState {
  String error;
  Error({required this.error});
}

class UnknownCommand extends VoiceCommandsState {}

class OrderFood extends VoiceCommandsState {}
class StartChatting extends VoiceCommandsState {}
class ChatBot extends VoiceCommandsState {}

class Stopped extends VoiceCommandsState{}
class Started extends VoiceCommandsState{}

class Delivery extends VoiceCommandsState{}

class Appointment extends VoiceCommandsState{}