import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/speech_to_text.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/book_apointment.dart';
import 'package:meta/meta.dart';

part 'voice_commands_event.dart';
part 'voice_commands_state.dart';

class VoiceCommandsBloc extends Bloc<VoiceCommandsEvent, VoiceCommandsState> {
  SpeechToText speechToText = SpeechToText();

  VoiceCommandsBloc() : super(VoiceCommandsInitial()) {
    on<VoiceCommandsEvent>((event, emit) async {
      if (event is Initialize) {
        await speechToText.initSpeech();
      }
      if (event is Listen) {
        if (speechToText.lastWords.isNotEmpty) {
          speechToText.lastWords = "";
        }
        if (!speechToText.speechEnabled) {
          if (!await speechToText.speechToText.hasPermission) {
            emit(Error(error: "Please give the app required permissions"));
          } else if (!speechToText.speechToText.isAvailable) {
            emit(Error(error: "Speech to text not available on device"));
          }
        } else {
          emit(Started());
          await speechToText.startListening();
          await Future.delayed(const Duration(seconds: 5), () {
            if (speechToText.speechToText.isListening) {
              speechToText.stopListening();
            }
            emit(Stopped());
            if (speechToText.lastWords == "order food") {
              emit(OrderFood());
            } else if (speechToText.lastWords == "start chatting") {
              emit(StartChatting());
            } else if (speechToText.lastWords == "help") {
              emit(ChatBot());
            } else if (speechToText.lastWords == "request delivery") {
              emit(Delivery());
            }else if (speechToText.lastWords == "book appointment") {
              emit(Appointment());
            }else {
              emit(UnknownCommand());
            }
          });
        }
      }
    });
  }
}
