// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateAllStatuses(
    dynamic itemsOutOfStock, // Карта с элементами "items_out_of_stock"
    String newStatus // Новое значение для статуса
    ) async {
  // Проходим по всем элементам карты и меняем значение статуса
  itemsOutOfStock.forEach((key, value) {
    if (value is Map<String, dynamic> && value.containsKey('status')) {
      value['status'] = newStatus; // Обновляем статус для каждого элемента
    }
  });

  // Эмуляция асинхронной операции (например, если нужно работать с сетью или базой данных)
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
