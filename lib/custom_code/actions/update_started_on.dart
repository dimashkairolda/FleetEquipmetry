// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateStartedOn(List<dynamic> jsonData, int searchId) async {
  bool updated = false; // Флаг для отслеживания, было ли обновление выполнено

  // Проходим по массиву JSON, чтобы найти соответствующий элемент
  for (var item in jsonData) {
    if (item['id'] == searchId) {
      // Устанавливаем сегодняшнюю дату в поле finished_on
      item['started_on'] = DateTime.now().toIso8601String();
      print('Finished_on updated for ID: $searchId to ${item['started_on']}');
      return;
    }
  }

  if (!updated) {
    print(
        'No matching data found to update.'); // Выводим сообщение, если обновление не выполнено
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
