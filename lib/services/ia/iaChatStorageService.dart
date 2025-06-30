import 'dart:convert';
import 'package:estudazz_main_code/models/ia/iaChatModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IaChatStorageService {
  static final String _storageKey = dotenv.env['IA_CHAT_STORAGE_KEY'] ?? '';

  static Future<void> saveMessages(List<IaChatModel> messages) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList =
        messages
            .map((message) => {'text': message.text, 'isUser': message.isUser})
            .toList();

    final encoded = jsonEncode(jsonList);
    await prefs.setString(_storageKey, encoded);
  }

  static Future<List<IaChatModel>> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List;
    return decoded
        .map((json) => IaChatModel(text: json['text'], isUser: json['isUser']))
        .toList();
  }

  static Future<void> clearMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
