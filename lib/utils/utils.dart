import 'dart:convert';
import 'package:http/http.dart' as http;

class Command {
  static final all = [hello];

  static const hello = 'hello car';
}

class Utils {
  static void scanText(String rawText, String apiUrl) {
    final text = rawText.toLowerCase();
    if (text.contains(Command.hello)) {
      final cmd = _getTextAfterCommand(text: text, command: Command.hello);

      if (cmd == 'park' || cmd == 'stop') {
        _sendCommand(cmd, apiUrl);
      } else {

      }
    }  
  }

  static String _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return '';
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future _sendCommand(String cmd, String apiUrl) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.http(apiUrl, '/command'),
        headers: {"Content-Type": "application/json", "Connection": "keep-alive"},
        body: json.encode({'command': cmd }));
      if (response.statusCode == 200) { 
        print('Request OK');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } finally {
      client.close();
    }
  }
}
