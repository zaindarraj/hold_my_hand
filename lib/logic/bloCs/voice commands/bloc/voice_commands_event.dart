part of 'voice_commands_bloc.dart';

@immutable
abstract class VoiceCommandsEvent {}

class Initialize extends VoiceCommandsEvent{}


class Listen extends VoiceCommandsEvent{ }

class Stop extends VoiceCommandsEvent{}

