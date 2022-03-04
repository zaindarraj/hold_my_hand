import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText {
  stt.SpeechToText speechToText = stt.SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  Future<void> initSpeech() async {
    try {
      speechEnabled = await speechToText.initialize();
    } on stt.SpeechToTextNotInitializedException catch (e) {
      print(e.toString());
    }
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult, partialResults: false);
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    print(lastWords);
  }
}
