// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateResponseByIdZamery(List<dynamic> jsonData, int searchId,
    int equipmentId, String formTitle, String newResponse) async {
  bool updated = false; // Флаг для отслеживания, было ли обновление выполнено

  // Проходим по массиву JSON, чтобы найти соответствующий элемент
  for (var item in jsonData) {
    if (item['id'] == searchId) {
      // Проверяем, соответствует ли ID искомому
      print('Found matching ID: $searchId');
      if (item.containsKey('responses')) {
        for (var response in item['responses']) {
          if (response['regulation_work_info']['equipment'] == equipmentId) {
            for (var formResult in response['form_result']) {
              if (formResult['data']['title'] == formTitle) {
                formResult['result']['response'] =
                    newResponse; // Обновляем значение
                print('Response updated for $formTitle to $newResponse');
                updated = true;
                break; // Прерываем цикл после успешного обновления
              }
            }
          }
          if (updated)
            break; // Если обновление выполнено, прерываем внешний цикл
        }
      }
      if (updated)
        break; // Если обновление выполнено, прерываем самый внешний цикл
    }
  }

  if (!updated) {
    print(
        'No matching data found to update.'); // Выводим сообщение, если обновление не выполнено
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
