// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateItemByPrice(
    dynamic jsonData, // Входные JSON данные в виде Map
    String itemName, // Название элемента, который нужно обновить
    int? price, // Новое значение quantity
    int quantity,
    String? status,
    String? date // Новое значение quantity
    ) async {
  // Проверяем, существует ли элемент с заданным названием в карте
  if (jsonData.containsKey(itemName)) {
    print('Found matching item: $itemName');

    // Вычисляем новое значение для quantity

    // Обновляем данные элемента
    jsonData[itemName] = {
      "quantity": quantity,
      "price": price,
      "status": status,
      "approximate_delivery_date": date,
      "delivered_at": null
    };
  } else {
    print(
        'No matching item found to update.'); // Сообщение, если элемент не найден
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
