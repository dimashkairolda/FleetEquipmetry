// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateItemByName(
    List<dynamic> jsonData, // ТЕПЕРЬ ЭТО LIST (список JSON объектов)
    String itemName, // Название элемента для поиска (по полю title)
    double newQuantity, // Сколько пользователь ввел (В наличии)
    double threshold // Сколько требовалось изначально (Total Needed)
    ) async {
  bool found = false;

  // Перебираем список
  for (var item in jsonData) {
    // Проверяем, является ли элемент картой и совпадает ли название
    if (item is Map && item['title'].toString() == itemName) {
      found = true;
      print('Found matching item in List: $itemName');

      // Логика расчета дефицита (сколько не хватает)
      // Если ввели больше или равно чем нужно -> дефицит 0
      // Если ввели меньше -> дефицит = (Нужно - В наличии)
      double updatedQuantity;
      if (newQuantity >= threshold) {
        updatedQuantity = 0;
      } else {
        updatedQuantity = threshold - newQuantity;
      }

      // Обновляем поле quantity внутри найденного объекта
      item['quantity'] = updatedQuantity;

      // Если нужно также обновлять/добавлять другие поля (как в прошлом коде):
      // item['price'] = 0;
      // item['status'] = "OUT_OF_STOCK";

      print(
          'Item $itemName updated with new deficit quantity: $updatedQuantity');
      break; // Прерываем цикл, так как нашли элемент
    }
  }

  if (!found) {
    print('No matching item found in List to update.');
  }
}
