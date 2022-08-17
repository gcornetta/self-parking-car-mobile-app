import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  // SpeechToText Plugin must be set up for IoS 
  // in ios/runner/info.plist and and for Android 
  // in android/local.properties. Permission enabled in
  // android/src/app/main/AndroidManifest.xml
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {

    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error: $e'),
    );

    if (isAvailable) {
      _speech.listen(onResult: (value) => onResult(value.recognizedWords));
    }

    return isAvailable;
  }
}