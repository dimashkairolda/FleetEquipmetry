// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/custom_code/widgets/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// This action sends user input to Gemini Pro and returns structured JSON
Future<dynamic> generateDefectFromGemini(String userInput) async {
  const apiKey =
      'AIzaSyAC9T3Xo0DkTPPon8mlX7_IYzO_zMUSooU'; // 👈 вставь сюда свой Google API key
  const endpoint =
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey';

  final prompt = '''
Ты — умный бот внутри мобильного приложения по управлению автопарком (fleet management system). Твоя задача — помочь пользователю быстро и удобно зафиксировать проблему с техникой, указать причину, нужные запчасти и что нужно сделать. Ты заполняешь структуру JSON по следующим полям:
[{
"title": "" – краткое название неисправности или задачи (например, "Сломался стартер").
"reason": "" – причина поломки или описание проблемы (например, "Мотор не заводится, подозрение на стартер").
"spare_parts": [  // список необходимых запчастей
  {
    "title": "",  // наименование (например, "Стартер Bosch")
    "product_article": "",  // артикул, если есть (например, "BOSCH-STR-203")
    "quantity": "" // количество штук (например, "1")
  }
],
"todo": [  // список задач, что нужно сделать
  {
    "title": "",  // наименование задачи (например, "Заменить стартер")
    "quantity": "" // сколько раз выполнить или сколько техники требует (например, "1")
  }
]

Ввод: "$userInput"
Ответи ТОЛЬКО JSON формата, без пояснений.
''';

  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": prompt}
        ]
      }
    ]
  });

  final response = await http.post(
    Uri.parse(endpoint),
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final text = data['candidates'][0]['content']['parts'][0]['text'];

    try {
      final jsonText = RegExp(r'\{[\s\S]*\}').firstMatch(text)?.group(0);

      if (jsonText == null) {
        throw Exception('JSON не найден в ответе Gemini.');
      }

      final jsonResult = json.decode(jsonText);
      return Map<String, dynamic>.from(jsonResult);
    } catch (e) {
      throw Exception('Ошибка разбора JSON: $e');
    }
  } else {
    throw Exception('Ошибка Gemini API: ${response.body}');
  }
}
