import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../api/speech_api.dart';
import '../main.dart';
import '../widgets/substring_highlighted.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);

                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('✓   Copied to Clipboard')),
                  );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(bottom: 150),
          child: SubstringHighlight(
            text: text,
            terms: Command.all,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            textStyleHighlight: const TextStyle(
              fontSize: 32.0,
              color: Colors.red,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(const Duration(seconds: 1), () {
              Utils.scanText(text, dotenv.get('API_URL', fallback: 'http://192.168.1.6:6000'));
            });
          }
        },
      );
}
