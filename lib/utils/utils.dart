import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Command {
  static final all = [hello];
  static const hello = 'hello car';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();
    if (text.contains(Command.hello)) {
      final cmd = _getTextAfterCommand(text: text, command: Command.hello);

      if (cmd == 'park' || cmd == 'stop') {
        _sendCommand(cmd);
      } else {

      }
    }  
  }

  static String _getTextAfterCommand({
    @required String text,
    @required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future _sendCommand(String cmd) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.http('http://192.168.100.1:6000', '/command'),
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
