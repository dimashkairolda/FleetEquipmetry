// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> extractVehicleDataGemini(
  List<String> imageBase64,
  List<dynamic> categoryList,
  List<dynamic> brandList,
  List<dynamic> modelList,
) async {
  const apiKey =
      'AIzaSyAC9T3Xo0DkTPPon8mlX7_IYzO_zMUSooU'; // 👈 Замени на свой ключ
  const endpoint =
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey';

  // Преобразуем списки в строки JSON
  final categoryJson = jsonEncode(categoryList);
  final brandJson = jsonEncode(brandList);
  final modelJson = jsonEncode(modelList);

  final prompt = '''
Ты помощник по распознаванию данных о транспорте с изображений.

Используй следующие списки, чтобы определить:
- Гос. номер
- VIN
- Категорию (по соответствию бренда)
- Бренд
- Модель
- Год
- Номер тех паспорта
- Цвет, мощность и объём двигателя (если указаны)
- ФИО владельца (если есть)
- Средний расход (можешь поискать типовую информацию в интернете по бренду/модели/двигателю)

Категории:
$categoryJson

Бренды:
$brandJson

Модели:
$modelJson

Верни результат ТОЛЬКО в этом JSON-формате:

{
  "category_id": "...",
  "category_name": "...",
  "brand_id": "...",
  "brand_name": "...",
  "model_id": "...",
  "model_name": "...",
  "year": "...",
  "tech_number": "...",
  "gov_number": "...",
  "vin": "...",
  "power_kw": "...",
  "engine_volume": "...",
  "color": "...",
  "average_fuel_consumption": "...",(можешь поискать типовую информацию в интернете по бренду/модели/двигателю)
  "owner": "..."
}
''';

  try {
    // Формируем parts с текстом + несколькими изображениями
    final parts = [
      {"text": prompt},
      ...imageBase64.map((img) => {
            "inlineData": {
              "mimeType": "image/jpeg",
              "data": img,
            }
          })
    ];

    final requestBody = jsonEncode({
      "contents": [
        {"parts": parts}
      ]
    });

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final replyText =
          responseBody['candidates'][0]['content']['parts'][0]['text'];

      final jsonText = RegExp(r'\{[\s\S]*\}').firstMatch(replyText)?.group(0);

      if (jsonText == null) {
        throw Exception('Gemini не вернул JSON.');
      }

      final result = json.decode(jsonText);
      return Map<String, dynamic>.from(result);
    } else {
      throw Exception('Ошибка Gemini API: ${response.body}');
    }
  } catch (e) {
    return {
      "error": "Ошибка: $e",
    };
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
