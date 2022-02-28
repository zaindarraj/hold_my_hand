import 'package:flutter/material.dart';
import 'package:hold_my_hand/classes/speech_to_text.dart';

class VoiceCommand extends StatefulWidget {
  const VoiceCommand({Key? key}) : super(key: key);

  @override
  _VoiceCommandState createState() => _VoiceCommandState();
}

class _VoiceCommandState extends State<VoiceCommand> {
  SpeechToText speechToText = SpeechToText();
  @override
  void initState() {
    speechToText.initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          speechToText.startListening();
        },
      ),
      body: Container(),
    );
  }
}
