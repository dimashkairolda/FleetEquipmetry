import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/auth/custom_auth/auth_util.dart';

Color? colorCTObackground(String? value) {
  Color color = Colors.black;
  if (value == 'Заявка сформирована') {
    color = Color(0xFFEBF1FF);
  } else if (value == 'Отправлено в СТО' ||
      value == 'Принято' ||
      value == 'В работе') {
    color = Color(0xFFFCF0DB);
  } else if (value == 'На согласование КП' || value == 'На приемке') {
    color = Color(0xFFEBDBFC);
  } else if (value == 'КП утвержден' || value == 'Машина отремонтирована') {
    color = Color(0xFFD6F3E9);
  } else if (value == 'Готов к ремонту') {
    color = Color(0xFFFFE5F6);
  } else {
    color = Color(0xFFFFDADA);
  }

  return color;
}

Color? approvalTEXTcolor(String? status) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (status == null) return Color(0xFF667085);

  switch (status.toLowerCase()) {
    case 'pending':
      return Color(0xFF667085);
    case 'approved':
      return Color(0xFF045130);
    case 'rejected':
      return Color(0xFF8B150C);
    case 'partially_approved':
      return Color(0xFF1570EF);
    default:
      return Color(0xFF667085);
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

String? approvalStatus(String? status) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (status == null) return 'В ожидании';

  switch (status.toLowerCase()) {
    case 'pending':
      return 'В ожидании';
    case 'approved':
      return 'Одобрено';
    case 'rejected':
      return 'Отклонено';
    case 'partially_approved':
      return 'Одобрено частично';
    default:
      return status; // Возвращаем сам статус, если перевод не найден
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}


Color? approvalBGcolor(String? status) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (status == null) return Color(0xFFF2F4F7);

  switch (status.toLowerCase()) {
    case 'pending':
      return Color(0xFFF2F4F7);
    case 'approved':
      return Color(0xFFD6F3E9);
    case 'rejected':
      return Color(0xFFFFDADA);
    case 'partially_approved':
      return Color(0xFFEBF5FF);
    default:
      return Color(0xFFF2F4F7);
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

Color? coloProcumentBG(String? status) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (status == 'NEW') {
    return Color(0xFF4A90E2); // Ярко-голубой (Deep Sky Blue)
  } else if (status == 'AWAITING_APPROVAL_PUBLICATION') {
    return Color(0xFF6554C0); // Ярко-зелёный (Green Accent)
  } else if (status == 'APPROVAL_PUBLICATION_DENIED') {
    return Color(0xFFDE350B); // Ярко-зелёный (Green Accent)
  } else if (status == 'AWAITING_PUBLICATION') {
    return Color(0xFFff991f); // Насыщенный жёлтый (Yellow Accent)
  } else if (status == 'DRAFT') {
    return Color(0xFFff991f); // Яркий золотистый (Amber Accent)
  } else if (status == 'PUBLISHED') {
    return Color(0xFF0052CC);
  } else if (status == 'COMPARE_OFFERS') {
    return Color(0xFF0065FF); // Яркий золотистый (Amber Accent)
  } else if (status == 'COLLECTING_KP') {
    return Color(0xFF36B37E); // Яркий синий (Blue Accent)
  } else if (status == 'SENT_KP') {
    return Color(0xFF0065FF); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'REJECTED_KP') {
    return Color(0xFFDE350B); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'AWAITING_APPROVAL_APPROVER') {
    return Color(0xFF6554c0); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'APPROVAL_DENIED') {
    return Color(0xFFDE350B); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'DENIED') {
    return Color(0xFFDE350B); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'CONFIRMED_KP') {
    return Color(0xFFFF991F); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'CONFIRMED_PARTIALLY_KP') {
    return Color(0xFFFF991F); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'AWAITING_APPROVAL_COUNTERPARTY') {
    return Color(0xFFFFAB00); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'AWAITING_PAYMENT') {
    return Color(0xFFFF991F); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'PAID') {
    return Color(0xFF0065FF); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'AWAITING_PAYMENT_VERIFICATION') {
    return Color(0xFFFFAB00); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'AWAITING_SHIPMENT') {
    return Color(0xFF17A2B8); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'CONFIRMED_PAYMENT') {
    return Color(0xFF36B37E); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'SENT') {
    return Color(0xFFF39C12); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'AWAITING_ORDER_CONFIRMATION') {
    return Color(0xFFFFAB00); // Ярко-оранжевый (Orange Accent)
  } else {
    return Color(0xFF438B5D); // Светло-серый
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
String? procurementStatus(String? status) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  switch (status) {
    case 'NEW':
      return 'Создано';

    case 'AWAITING_APPROVAL_PUBLICATION':
    case 'AWAITING_APPROVAL_APPROVER':
      return 'На согласовании';

    case 'APPROVAL_PUBLICATION_DENIED':
    case 'APPROVAL_DENIED':
      return 'Не согласован';

    case 'AWAITING_PUBLICATION':
      return 'Ожидает публикации';

    case 'DRAFT':
      return 'Черновик';

    case 'PUBLISHED':
      return 'Опубликовано';

    case 'COMPARE_OFFERS':
      return 'Сравнение предложений';

    case 'COLLECTING_KP':
      return 'Новая - сбор предложений';

    case 'SENT_KP':
      return 'КП отправлено';

    case 'REJECTED_KP':
      return 'КП отклонен';

    case 'DENIED':
      return 'Отклонен';

    case 'CONFIRMED_KP':
    case 'CONFIRMED_PARTIALLY_KP':
    case 'AWAITING_PAYMENT':
      return 'Ожидание оплаты';

    case 'AWAITING_APPROVAL_COUNTERPARTY':
      return 'Утверждение заказа';

    case 'PAID':
      return 'Оплачен';

    case 'AWAITING_PAYMENT_VERIFICATION':
      return 'Ожидание подтверждения оплаты';

    case 'AWAITING_SHIPMENT':
      return 'Готово к отгрузке';

    case 'CONFIRMED_PAYMENT':
      return 'Оплата подтверждена';

    case 'SENT':
      return 'Отправлено';

    case 'AWAITING_ORDER_CONFIRMATION':
      return 'На приемке';

    case 'FINISHED':
      return 'Завершена';

    default:
      return 'Неизвестный статус'; // Или 'Пропущен', как в вашем примере
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
List<dynamic> formatTodoList(List<dynamic> rawList) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  int parseToInt(dynamic value, int defaultValue) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  return rawList.map((item) {
    // Приводим item к Map, на случай если пришел dynamic
    final mapItem = item as dynamic;

    return {
      "title": mapItem["title"],
      // Если order_num нет или null -> ставим 1
      "order_num": parseToInt(mapItem["order_num"], 1),
      // Если quantity нет или null -> ставим 1
      "quantity": parseToInt(mapItem["quantity"], 1),
      // Остальные поля по умолчанию будут null, если их нет в mapItem
      "price": mapItem["price"],
      "defect_id": mapItem["defect_id"],
    };
  }).toList();

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

List<dynamic> updateWorksList(
  List<dynamic> works,
  String maintenanceId,
  String workspaceId,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  return works.map((item) {
    // Создаем копию объекта, чтобы не мутировать исходный список напрямую
    // и убеждаемся, что это Map
    Map<String, dynamic> newItem = Map<String, dynamic>.from(item);

    // Добавляем переданные ID
    newItem['maintenance_id'] = maintenanceId;
    newItem['workspace_id'] = workspaceId;

    // Устанавливаем defect_id в null
    newItem['defect_id'] = null;

    // Логика для quantity:
    // Если поля нет или оно null -> ставим 1
    // Если поле есть -> оставляем как есть (dont change quantity field)
    if (!newItem.containsKey('quantity') || newItem['quantity'] == null) {
      newItem['quantity'] = 1;
    }

    return newItem;
  }).toList();

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

Color hexToColor(String hex) {
  String formatted = hex.toUpperCase().replaceAll('#', '').trim();

  // Поддержка короткого формата #RGB -> #RRGGBB
  if (formatted.length == 3) {
    formatted = formatted.split('').map((c) => c * 2).join();
  }

  // Если указано только RRGGBB — добавляем непрозрачный альфа-канал (FF)
  if (formatted.length == 6) {
    formatted = 'FF$formatted';
  }

  // Проверка корректности
  if (formatted.length != 8) {
    throw FormatException('Неверный формат цвета: $hex');
  }

  // Конвертируем в int и возвращаем Color
  return Color(int.parse(formatted, radix: 16));
}

String? statusApproval(String? status) {
  if (status == 'ON_APPROVAL') {
    return 'У согласовантов';
  } else {
    return 'Согласовано';
  }
}

Color? colorApproval(String? status) {
  if (status == 'NEW') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'CHECKED') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFF3466E7); // Жёлтый
  } else if (status == 'PURCHASED') {
    return Color(0xFF3466E7); // Оранжевый
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'DONE') {
    return Color(0xFF3466E7); // Зелёный
  }
  else if (status == 'ON_APPROVAL') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'APPROVED') {
    return Color(0xFF3466E7); // Зелёный
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

String? statusSbor(String? status) {
  if (status == 'COLLECTING_OFFERS') {
    return 'Поиск цены';
  } else {
    return 'Готов';
  }
}

Color? colorSbor(String? status) {
  if (status == 'NEW') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFF3466E7); // Жёлтый
  } else if (status == 'PURCHASED') {
    return Color(0xFF3466E7); // Оранжевый
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'APPROVED') {
    return Color(0xFF3466E7); // Золотистый
  } else if (status == 'ON_APPROVAL') {
    return Color(0xFF3466E7); // Золотистый
  } else if (status == 'DONE') {
    return Color(0xFF3466E7); // Золотистый
  }
  else if (status == 'COLLECTING_OFFERS') {
    return Color(0xFF3466E7); // Золотистый
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color brightenColor(Color color) {
  // Преобразуем в HSL (тон, насыщенность, яркость)
  final hsl = HSLColor.fromColor(color);
  // Увеличиваем яркость, не превышая 1.0
  final hslBright = hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0));
  // Возвращаем обратно в Color
  return hslBright.toColor();
}

List<dynamic> filterbyPerformer(
  List<dynamic> items,
  String userId,
) {
  return items.where((item) {
    // 1. Безопасно получаем список 'performers'.
    // Используем '?' для защиты от null, если 'form' вдруг отсутствует.
    final performersList = item['form']?['performers'];

    // 2. Убеждаемся, что 'performersList' - это действительно список (List).
    if (performersList is List) {
      // 3. Используем .any() - это самый эффективный способ.
      // Он проверяет, есть ли *хотя бы один* элемент в списке,
      // который соответствует условию.
      return performersList.any((performer) {
        // 4. Убеждаемся, что 'performer' - это Map (объект)
        // и его 'id' равен искомому 'userId'.
        if (performer is Map<String, dynamic>) {
          return performer['id'] == userId;
        }
        return false; // Элемент в списке performers - не Map.
      });
    }

    // 5. Возвращаем false, если 'performers' - не список или отсутствует.
    return false;
  }).toList();
}

Color? statusReglamentTextColor(String? status) {
  if (status == 'IN_PROGRESS') {
    return Color(0xFF7F3004);
  } else if (status == 'PASSED') {
    return Color(0xFF045130);
  } else if (status == 'SOON') {
    return Color(0xFF7F3004);
  } else if (status == 'ON_THE_WAY') {
    return Color(0xFF8291B0);
  } else if (status == 'EXPIRED') {
    return Color(0xFF8B150C);
  } else {
    return Color(0xFF8291B0);
  }
}

List<InventoryItemsStruct> toOneListCTOINventoryItemsCopy(
  List<InventoryItemsStruct> list1,
  List<InventoryItemsStruct> list2,
  String defectId,
) {
  List<InventoryItemsStruct> combinedList = [];
  combinedList.addAll(list1);

  // Копируем элементы из list2, добавляя каждому defectId
  combinedList.addAll(list2.map((item) {
    return InventoryItemsStruct(
      quantity: item.quantity,
      productArticle: item.productArticle,
      title: item.title,
      unitOfMeasurement: item.unitOfMeasurement,
      price: item.price,
      inStock: item.inStock,
      defectId: defectId, // заменяем значение
    );
  }));

  return combinedList;
}

Color? statusReglamentBGColor(String? status) {
  if (status == 'IN_PROGRESS') {
    return Color(0xFFFCF0DB);
  } else if (status == 'PASSED') {
    return Color(0xFFD6F3E9);
  } else if (status == 'SOON') {
    return Color(0xFFFCF0DB);
  } else if (status == 'ON_THE_WAY') {
    return Color(0xFFF2F4F7);
  } else if (status == 'EXPIRED') {
    return Color(0xFFFFDADA);
  } else {
    return Color(0xFFF2F4F7);
  }
}

List<InventoryItemsStruct> toSht(List<InventoryItemsStruct> list1) {
  List<InventoryItemsStruct> combinedList = [];

  // Копируем элементы из list2, добавляя каждому defectId
  combinedList.addAll(list1.map((item) {
    return InventoryItemsStruct(
      quantity: item.quantity,
      productArticle: item.productArticle,
      title: item.title,
      unitOfMeasurement: (item.unitOfMeasurement == null ||
              item.unitOfMeasurement!.trim().isEmpty)
          ? "шт"
          : item.unitOfMeasurement,

      price: null,
      inStock: item.inStock,
      defectId: item.defectId, // заменяем значение
    );
  }));

  return combinedList;
}

String? periodReglament(String? status) {
  if (status == 'daily') {
    return 'Ежедневно';
  } else if (status == 'weekly') {
    return 'Еженедельно';
  } else if (status == 'monthly') {
    return 'Ежемесячно';
  } else {
    return 'Ежегодно';
  }
}

List<WorksStruct> toOneListCTOWorks(
  List<WorksStruct> list1,
  List<WorksStruct> list2,
  String defectId,
) {
  List<WorksStruct> combinedList = [];
  combinedList.addAll(list1);

  combinedList.addAll(list2.map((item) {
    return WorksStruct(
      quantity: item.quantity,
      title: item.title,
      defectId: defectId, // заменяем значение
    );
  }));

  return combinedList;
}

Color? colorCTOtext(String? value) {
  Color color = Colors.black;
  if (value == 'Заявка сформирована') {
    color = Color(0xFF3466E7);
  } else if (value == 'Отправлено в СТО' ||
      value == 'Принято' ||
      value == 'В работе') {
    color = Color(0xFF7F3004);
  } else if (value == 'На согласование КП' || value == 'На приемке') {
    color = Color(0xFF66047F);
  } else if (value == 'КП утвержден' || value == 'Машина отремонтирована') {
    color = Color(0xFF045130);
  } else if (value == 'Готов к ремонту') {
    color = Color(0xFF76015C);
  } else {
    color = Color(0xFF8B150C);
  }

  return color;
}

List<String> combineTechnics(
  List<String> brand,
  List<String> model,
  List<String> license,
) {
  List<String> fullNames = [];

  for (int i = 0; i < model.length; i++) {
    fullNames.add('${brand[i]} ${model[i]} (${license[i]})');
  }

  return fullNames;
}

Color? colormaintenancebackgroundCopy(String? value) {
  Color color = Colors.black;
  if (value == 'SOON') {
    color = Color(0xFFFFF3E0);
  } else if (value == 'EXPIRED') {
    color = Color(0xFFFDE7E7);
  } else if (value == 'UPCOMING') {
    color = Color(0xFFEFF1F5);
  } else if (value == 'MISSED') {
    color = Color(0xFFB2BBCE);
  } else {
    color = Color(0xFFE2FEE6);
  }

  return color;
}

String? statusCTO2(String? status) {
  if (status == 'Принято') {
    return 'Принято';
  } else if (status == 'Отказано') {
    return 'Отказано';
  } else {
    return 'Составлен КП';
  }
}

String? statusReglament(String? status) {
  if (status == 'IN_PROGRESS') {
    return 'В процессе';
  } else if (status == 'PASSED') {
    return 'Пройден';
  } else if (status == 'SOON') {
    return 'Скоро';
  } else if (status == 'ON_THE_WAY') {
    return 'На подходе';
  } else if (status == 'EXPIRED') {
    return 'Просрочен';
  } else {
    return 'Пропущен';
  }
}

String? statusCTO(String? status) {
  if (status == 'Принято') {
    return 'Принято';
  } else if (status == 'Заявка сформирована') {
    return 'Заявка сформирована';
  } else if (status == 'Отказано') {
    return 'Отказано';
  } else if (status == 'Составлен КП') {
    return 'Составлен КП';
  } else if (status == 'На согласование КП') {
    return 'На согласование КП';
  } else if (status == 'КП отказано') {
    return 'КП отказано';
  } else if (status == 'КП утвержден') {
    return 'КП утвержден';
  } else if (status == 'На приемке') {
    return 'На приемке';
  } else if (status == 'Приемка отклонена') {
    return 'Приемка отклонена';
  } else if (status == 'Машина отремонтирована') {
    return 'Машина отремонтирована';
  } else if (status == 'Машина не приехала') {
    return 'Машина не приехала';
  } else if (status == 'Готов к ремонту') {
    return 'Готов к ремонту';
  } else if (status == 'В работе') {
    return 'В работе';
  } else {
    return 'Отправлено в СТО';
  }
}

String? cTOType(String? status) {
  if (status == 'REPAIR') {
    return 'Ремонт';
  } else {
    return 'График обслуживания';
  }
}

String? statusCTO3(String? status) {
  if (status == 'На согласование КП') {
    return 'На согласование КП';
  } else if (status == 'КП отказано') {
    return 'КП отказано';
  } else {
    return 'КП утвержден';
  }
}

String? statusCTO5(String? status) {
  if (status == 'На приемке') {
    return 'На приемке';
  } else if (status == 'Приемка отклонена') {
    return 'Приемка отклонена';
  } else {
    return 'Машина отремонтирована';
  }
}

Color? colorRemontCopy(String? status) {
  if (status == 'NEW') {
    return Color(0xFF00BFFF); // Ярко-голубой (Deep Sky Blue)
  } else if (status == 'ISSUED') {
    return Color(0xFF00E676); // Ярко-зелёный (Green Accent)
  }else if (status == 'DONE') {
    return Color(0xFF00E676); // Ярко-зелёный (Green Accent)
  }
   else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFFFFEA00); // Насыщенный жёлтый (Yellow Accent)
  } else if (status == 'CHECKED') {
    return Color(0xFFFFD740); // Яркий золотистый (Amber Accent)
  } else if (status == 'IN_PROGRESS') {
    return Color(0xFFFFD740); // Яркий золотистый (Amber Accent)
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF2979FF); // Яркий синий (Blue Accent)
  } else if (status == 'PURCHASED') {
    return Color(0xFFFF6D00); // Ярко-оранжевый (Orange Accent)
  } else {
    return Color(0xFFBDBDBD); // Светло-серый
  }
}

String? statusCTO4(String? status) {
  if (status == 'Машина не приехала') {
    return 'Машина не приехала';
  } else if (status == 'Готов к ремонту') {
    return 'Готов к ремонту';
  } else {
    return 'На ремонте';
  }
}

dynamic emptyMap() {
  return {};
}

String? statusCTO1(String? status) {
  if (status == 'Заявка сформирована') {
    return 'Заявка сформирована';
  } else {
    return 'Отправлено в СТО';
  }
}

Color? colorCTO6(String? status) {
  if (status == 'Заявка сформирована') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'Отправлено в СТО') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'Принято') {
    return Color(0xFFCFCFCF); // Жёлтый
  } else if (status == 'На согласование КП') {
    return Color(0xFFCFCFCF); // Оранжевый
  } else if (status == 'КП утвержден') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Готов к ремонту') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'В работе') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'На приемке') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'КП отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Машина не приехала') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Приемка отклонена') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Машина отремонтирована') {
    return Color(0xFF3466E7); // Синий
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorCTO5(String? status) {
  if (status == 'Заявка сформирована') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'Отправлено в СТО') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'Принято') {
    return Color(0xFFCFCFCF); // Жёлтый
  } else if (status == 'На согласование КП') {
    return Color(0xFFCFCFCF); // Оранжевый
  } else if (status == 'КП утвержден') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Готов к ремонту') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'В работе') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'На приемке') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'КП отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Машина не приехала') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Приемка отклонена') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Машина отремонтирована') {
    return Color(0xFF3466E7); // Синий
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorCTO4(String? status) {
  if (status == 'Заявка сформирована') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'Отправлено в СТО') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'Принято') {
    return Color(0xFFCFCFCF); // Жёлтый
  } else if (status == 'На согласование КП') {
    return Color(0xFFCFCFCF); // Оранжевый
  } else if (status == 'КП утвержден') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Готов к ремонту') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'В работе') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'На приемке') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'КП отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'Машина не приехала') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Приемка отклонена') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Машина отремонтирована') {
    return Color(0xFF3466E7); // Синий
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

String activeOrNotRus(String? string) {
  if (string == 'ACTIVE') {
    return 'Активный';
  } else if (string == 'NOT ACTIVE') {
    return 'Неактивный';
  } else {
    return 'Статус';
  }
}

String? jsonToString(dynamic resulttitle) {
  var dataConvertedToJSON = json.encode(resulttitle);
  // print(dataConvertedToJSON);
  return dataConvertedToJSON;
}

Color? colorCTO3(String? status) {
  if (status == 'Заявка сформирована') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'Отправлено в СТО') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'Составлен КП') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'Принято') {
    return Color(0xFFCFCFCF); // Жёлтый
  } else if (status == 'На согласование КП') {
    return Color(0xFF3466E7); // Оранжевый
  } else if (status == 'КП утвержден') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Готов к ремонту') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'В работе') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'На приемке') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Отказано') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'КП отказано') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Машина не приехала') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Приемка отклонена') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Машина отремонтирована') {
    return Color(0xFF3466E7); // Синий
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

String? carStatusToRus(String? status) {
  if (status == 'ACTIVE') {
    return 'На линии';
  } else {
    return 'Неисправен';
  }
}

int? stringToInt(String? name) {
  int num = int.parse(name!);
  return num;
}

String? statusToRus(String? status) {
  if (status == 'APPROVED') {
    return 'Исправен';
  } else if (status == 'ON_REPAIR') {
    return 'Акт сформирован';
  } else {
    return 'Неисправен';
  }
}

DateTime? stringToDateTimeUTC(String date) {
  try {
    // Удаляем " UTC", заменяем "+0000" на "Z" (эквивалент UTC)
    String cleaned = date.replaceAll(' UTC', '').replaceAll(' +0000', 'Z');
    return DateTime.parse(cleaned);
  } catch (e) {
    print('Error parsing date string: $e');
    return null;
  }
}

List<dynamic> transformDataDrivers(
  List<dynamic> originalData,
  List<DriverStruct>? drivers,
) {
  final DateFormat inputFormat = DateFormat('dd.MM.yyyy');
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String? processDate(String? date) {
    if (date == null) return null;

    // Если дата уже в формате yyyy-MM-dd
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(date)) {
      return date;
    }

    // Если дата в формате с временем, как 2025-01-05 00:00:00.000
    if (RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(\.\d+)?$')
        .hasMatch(date)) {
      return dateFormat.format(DateTime.parse(date));
    }

    // Если дата в формате dd.MM.yyyy
    return dateFormat.format(inputFormat.parse(date));
  }

  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": drivers
              ?.map((driver) => {
                    "id": driver.id,
                    "shift": driver.shift,
                    "date_arrival": processDate(driver.dateArrival),
                    "date_departure": processDate(driver.dateDeparture),
                  })
              .toList() ??
          [],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "column_assignees": item["column_assignees"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "equipment_release": item["equipment_release"],
      "work_type_id": item["work_type"]?["id"],
      "created_at": formattedDate
    };
  }).toList();
}

String? statusToRemont(String? status) {
  if (status == 'NEW') {
    return 'Сформировано';
  } else if (status == 'ISSUED') {
    return 'Готов к ремонту';
  }else if (status == 'DONE') {
    return 'Завершен';
  }
   else if (status == 'WAITING_FOR_PURCHASE') {
    return 'На закуп';
  } else if (status == 'PURCHASED') {
    return 'Закуплено';
  } else if (status == 'CHECKED') {
    return 'В обработке зав. склада';
  } else if (status == 'READY_FOR_ISSUE') {
    return 'Готово к выдаче';
  } else if (status == 'IN_PROGRESS') {
    return 'В работе';
  } else if (status == 'COLLECTING_OFFERS') {
    return 'Сбор предложений';
  } else if (status == 'APPROVED') {
    return 'Согласован';
  } else if (status == 'ON_APPROVAL') {
    return 'На согласовании';
  } else {
    return 'Не сформировано';
  }
}

List<dynamic>? filterRaport(
  List<dynamic> jsonData,
  String? searchTerm,
) {
  final titleLower = searchTerm?.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["title"]?.toLowerCase() ?? '';
    final licensePlateNumber =
        item["license_plate_number"]?.toLowerCase() ?? '';
    bool matchesSearchTerm = searchTerm == '' ||
        brandName?.contains(titleLower) ||
        licensePlateNumber?.contains(titleLower);
    return matchesSearchTerm;
  }).toList();
}

Color? colormaintenancetext(String? value) {
  Color color = Colors.black;
  if (value == 'SOON') {
    color = Color(0xFFd18100);
  } else if (value == 'EXPIRED') {
    color = Color(0xFFDC0E0E);
  } else if (value == 'UPCOMING') {
    color = Color(0xFF8291B0);
  } else if (value == 'MISSED') {
    color = Color(0xFFf9fafb);
  } else {
    color = Color(0xFF07971F);
  }

  return color;
}

Color? colorDefectCopy2(String? value) {
  Color color = Colors.black;
  if (value == 'APPROVED') {
    color = Color(0xFF1AB759);
  } else if (value == 'unworkable') {
    color = Color(0xFFFFE001);
  } else {
    color = Color(0xFFFF3B30);
  }

  return color;
}

Color? colorCTO2(String? status) {
  if (status == 'Заявка сформирована') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'Отправлено в СТО') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'Принято') {
    return Color(0xFF3466E7); // Жёлтый
  } else if (status == 'На согласование КП') {
    return Color(0xFF3466E7); // Оранжевый
  } else if (status == 'КП утвержден') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Готов к ремонту') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Составлен КП') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'В работе') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'На приемке') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Отказано') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'КП отказано') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Машина не приехала') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Приемка отклонена') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'Машина отремонтирована') {
    return Color(0xFF3466E7); // Синий
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorDefectCopyCopy(String? value) {
  Color color = Colors.black;
  if (value == 'APPROVED') {
    color = Color(0xFF60BF00);
  } else if (value == 'ON_REPAIR') {
    color = Color(0xFFE38E04);
  } else {
    color = Color(0xFFff4040);
  }

  return color;
}

List<dynamic>? filterSearchedEquipTree(
  List<dynamic> jsonData,
  String title,
) {
  final titleLower = title.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["brand_id"]?["name"]?.toLowerCase() ?? '';
    final modelName = item["model_id"]?["name"]?.toLowerCase() ?? '';
    final licensePlateNumber =
        item["license_plate_number"]?.toLowerCase() ?? '';
    return brandName.contains(titleLower) ||
        modelName.contains(titleLower) ||
        licensePlateNumber.contains(titleLower);
  }).toList();
}

Color? colorActive(String? value) {
  Color color = Colors.black;
  if (value == 'ACTIVE') {
    color = Color(0xFF34C759);
  } else {
    color = Color(0xFFFF3B30);
  }

  return color;
}

Color? colorNaryadsCopy(String? status) {
  if (status == 'IN_PROGRESS') {
    return Color(0xFFFCF0DB);
  } else if (status == 'NEW') {
    return Color(0xFFEBF1FF);
  } else if (status == 'PAUSED') {
    return Color(0xFFFFE5F6);
  } else if (status == 'FINALIZED') {
    return Color(0xFFD6F3E9);
  } else if (status == 'ACCEPTOR_REJECTED') {
    return Color(0xFFFFDADA);
  } else if (status == 'ON_ACCEPTOR_REVIEW') {
    return Color(0xFFEBDBFC);
  } else {
    return Color(0xFFF2F4F7);
  }
}

Color? colorDefectCopy(String? value) {
  Color color = Colors.black;
  if (value == 'APPROVED') {
    color = Color(0xFFF2FDE7);
  } else if (value == 'ON_REPAIR') {
    color = Color(0xFFFEEDD4);
  } else {
    color = Color(0xFFfde7e7);
  }

  return color;
}

Color? colorRemontText(String? status) {
  if (status == 'NEW') {
    return Color(0xFF3466E7); // Ярко-голубой (Deep Sky Blue)
  } else if (status == 'ISSUED') {
    return Color(0xFF045130); // Ярко-зелёный (Green Accent)
  }else if (status == 'DONE') {
    return Color(0xFF045130); // Ярко-зелёный (Green Accent)
  }
   else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFF66047F); // Насыщенный жёлтый (Yellow Accent)
  } else if (status == 'CHECKED') {
    return Color(0xFF667085); // Яркий золотистый (Amber Accent)
  } else if (status == 'COLLECTING_OFFERS') {
    return Color(0xFF3466E7);
  } else if (status == 'IN_PROGRESS') {
    return Color(0xFF7F3004); // Яркий золотистый (Amber Accent)
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF7F3004); // Яркий синий (Blue Accent)
  } else if (status == 'PURCHASED') {
    return Color(0xFF76015C); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'ON_APPROVAL') {
    return Color(0xFF76015C); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'APPROVED') {
    return Color(0xFF76015C); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'OUT_OF_STOCK') {
    return Color(0xFF8B150C); // Ярко-оранжевый (Orange Accent)
  } else {
    return Color(0xFFBDBDBD); // Светло-серый
  }
}

Color? colorRemontBG(String? status) {
  if (status == 'NEW') {
    return Color(0xFFEBF1FF); // Ярко-голубой (Deep Sky Blue)
  } else if (status == 'ISSUED') {
    return Color(0xFFD6F3E9); // Ярко-зелёный (Green Accent)
  }else if (status == 'DONE') {
    return Color(0xFFD6F3E9); // Ярко-зелёный (Green Accent)
  }
   else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFFEBDBFC); // Насыщенный жёлтый (Yellow Accent)
  } else if (status == 'CHECKED') {
    return Color(0xFFF2F4F7); // Яркий золотистый (Amber Accent)
  } else if (status == 'COLLECTING_OFFERS') {
    return Color(0xFFEBF1FF);
  } else if (status == 'IN_PROGRESS') {
    return Color(0xFFFCF0DB); // Яркий золотистый (Amber Accent)
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFFFCF0DB); // Яркий синий (Blue Accent)
  } else if (status == 'PURCHASED') {
    return Color(0xFFFFE5F6); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'ON_APPROVAL') {
    return Color(0xFFFFE5F6); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'APPROVED') {
    return Color(0xFFFFE5F6); // Ярко-оранжевый (Orange Accent)
  } else if (status == 'OUT_OF_STOCK') {
    return Color(0xFFFFDADA); // Ярко-оранжевый (Orange Accent)
  } else {
    return Color(0xFFBDBDBD); // Светло-серый
  }
}

List<dynamic> finddefectbyequipid(
  String idd,
  List<dynamic> jsonData,
) {
  return jsonData.where((item) => item["id"] == idd).toList();
}

Color? colorRemontTMC(String? status) {
  if (status == 'IN_PROGRESS') {
    return Color(0xFFFFC305); // Голубой
  } else if (status == 'PURCHASED') {
    return Color(0xFFFF8C00); // Зелёный
  } else if (status == 'DELIVERED') {
    return Color(0xFF1E90FF); // Жёлтый
  } else {
    return Color(0xFFA9A9A9); // Серый по умолчанию
  }
}

Color? colorNaryads(String? status) {
  if (status == 'IN_PROGRESS') {
    return Color(0xFF7F3004);
  } else if (status == 'NEW') {
    return Color(0xFF3466E7);
  } else if (status == 'PAUSED') {
    return Color(0xFF76015C);
  } else if (status == 'FINALIZED') {
    return Color(0xFF045130);
  } else if (status == 'ACCEPTOR_REJECTED') {
    return Color(0xFF8B150C);
  } else if (status == 'ON_ACCEPTOR_REVIEW') {
    return Color(0xFF66047F);
  } else {
    return Color(0xFF8291B0);
  }
}

String? formatDateTime(String? datetime) {
  var parsedDate = DateTime.parse(datetime!);
  final DateTime now = parsedDate;
  final DateFormat formatter = DateFormat('dd MM yyyy');
  final String formatted = formatter.format(now);
  return formatted;
}

Color? colorsklad(String? status) {
  if (status == 'NEW') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFF3466E7); // Жёлтый
  } else if (status == 'PURCHASED') {
    return Color(0xFF3466E7); // Оранжевый
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'APPROVED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'ON_APPROVAL') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'COLLECTING_OFFERS') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'OUT_OF_STOCK') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'DONE') {
    return Color(0xFF3466E7); // Зелёный
  }
  else if (status == 'CHECKED') {
    return Color(0xFF3466E7); // Золотистый
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorraport(String? status) {
  if (status == 'На парковке' || status == 'На ремонте') {
    return Color(0xFFFCF0DB); // Жёлтый
  } else if (status == 'Снят с линии' || status == 'Обнаружен дефект') {
    return Color(0xFFFFDADA); // Красный
  } else if (status == 'Исправен' || status == 'На линии') {
    return Color(0xFFD6F3E9); // Зелёный
  } else if (status == 'Консервация') {
    return Color(0xFFEBDBFC); // Зелёный
  } else if (status == 'На продажу') {
    return Color(0xFFEBF1FF); // Зелёный
  } else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorvidano(String? status) {
  if (status == 'NEW') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'CHECKED') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFFCFCFCF); // Жёлтый
  } else if (status == 'PURCHASED') {
    return Color(0xFFCFCFCF); // Оранжевый
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFFCFCFCF); // Синий
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'DONE') {
    return Color(0xFF3466E7); // Зелёный
  }
  else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorzakup(String? status) {
  if (status == 'NEW') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFF3466E7); // Жёлтый
  } else if (status == 'PURCHASED') {
    return Color(0xFF3466E7); // Оранжевый
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'DELIVERED') {
    return Color(0xFF3466E7); // Золотистый
  } else if (status == 'DONE') {
    return Color(0xFF3466E7); // Золотистый
  }
  else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

Color? colorready(String? status) {
  if (status == 'NEW') {
    return Color(0xFFCFCFCF); // Голубой
  } else if (status == 'CHECKED') {
    return Color(0xFFCFCFCF); // Золотистый
  } else if (status == 'WAITING_FOR_PURCHASE') {
    return Color(0xFFCFCFCF); // Жёлтый
  } else if (status == 'PURCHASED') {
    return Color(0xFFCFCFCF); // Оранжевый
  } else if (status == 'READY_FOR_ISSUE') {
    return Color(0xFF3466E7); // Синий
  } else if (status == 'ISSUED') {
    return Color(0xFF3466E7); // Зелёный
  } else if (status == 'DONE') {
    return Color(0xFF3466E7); // Зелёный
  }else {
    return Color(0xFFCFCFCF); // Серый по умолчанию
  }
}

String? statuspark(String? status) {
  if (status == 'ACTIVE') {
    return 'На линии';
  } else {
    return 'Не на линии';
  }
}

int? boolToInt(bool boolean) {
  if (boolean == true) {
    return 1;
  } else if (boolean == false) {
    return 0;
  }
}

List<dynamic> filterReglament(
  List<dynamic> items,
  String targetStatus,
) {
  return items.where((item) => item['status'] == targetStatus).toList();
}

bool? intToBool(int num) {
  if (num == 1) {
    return true;
  } else {
    return false;
  }
}

String? extractResponsesCopy(
  List<dynamic> jsonData,
  int index,
) {
  // Проверяем, что индекс находится в пределах диапазона списка
  if (index >= 0 && index < jsonData.length) {
    var item = jsonData[index];
    if (item.containsKey('started_on')) {
      return item[
          'started_on']; // Возвращаем список responses, если он существует
    }
  }
  return null; // Возвращаем null, если индекс вне диапазона или нет ключа 'responses'
}

String? jsonlistToString(List<dynamic> resulttitle) {
  var dataConvertedToJSON = json.encode(resulttitle);
  // print(dataConvertedToJSON);
  return dataConvertedToJSON;
}

bool equipmentOpened(
  String equipmentId,
  List<dynamic> jsonList,
) {
  try {
    // Парсим JSON-строку в список

    // Проверяем, содержит ли список объект с заданным equipment_id
    return jsonList.any((item) => item['equipment_id'] == equipmentId);
  } catch (e) {
    // Возвращаем false, если произошла ошибка
    return false;
  }
}

int? listlength(List<dynamic>? listt) {
  return listt?.length ?? 0;
}

String defectorNormal(String isNormal) {
  if (isNormal == 'normal') {
    return 'defect';
  } else {
    return 'normal';
  }
}

int indexOf(
  List<dynamic> listt,
  dynamic item,
) {
  int index = listt.indexWhere((map) =>
      map.keys.every((key) => item.containsKey(key) && map[key] == item[key]) &&
      item.keys.every((key) => map.containsKey(key) && map[key] == item[key]));
  return index;
}

List<dynamic> filterDefectiveDefect(dynamic jsonData) {
  return jsonData.where((item) => item["status"] != "APPROVED").toList();
}

String searchFromList(
  List<dynamic> listt,
  String item,
) {
  for (var map in listt) {
    if (map.containsKey(item)) {
      return map[item] ?? ''; // Возвращаем значение, если ключ найден
    }
  }
  return '';
}

List<dynamic> filterModelsByBrandId(
  List<dynamic> jsonList,
  String targetId,
) {
  return jsonList.where((item) => item['brand_id'] == targetId).toList();
}

List<dynamic>? filterSearched(
  List<dynamic> jsonData,
  String title,
) {
  final titleLower = title.toLowerCase();
  return jsonData.where((item) {
    final modelName = item["title"]?.toLowerCase() ?? '';

    return modelName.contains(titleLower);
  }).toList();
}

List<dynamic>? filterassets(
  List<dynamic> jsonData,
  String? searchTerm,
) {
  final titleLower = searchTerm?.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["brand_id"]?["name"]?.toLowerCase() ?? '';
    final modelName = item["model_id"]?["name"]?.toLowerCase() ?? '';
    final licensePlateNumber =
        item["license_plate_number"]?.toLowerCase() ?? '';
    bool matchesSearchTerm = searchTerm == '' ||
        brandName?.contains(titleLower) ||
        licensePlateNumber?.contains(titleLower) ||
        modelName?.contains(titleLower);
    return matchesSearchTerm;
  }).toList();
}

List<dynamic>? filterS(
  List<dynamic> jsonData,
  String? status,
  String? type,
  String? searchTerm,
) {
  final titleLower = searchTerm?.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["brand_id"]?["name"]?.toLowerCase() ?? '';
    final modelName = item["model_id"]?["name"]?.toLowerCase() ?? '';
    final licensePlateNumber =
        item["license_plate_number"]?.toLowerCase() ?? '';
    bool matchesType = type == '' || item['classification_id']['name'] == type;
    bool matchesRegion = status == '' || item['state'] == status;
    bool matchesSearchTerm = searchTerm == '' ||
        brandName?.contains(titleLower) ||
        licensePlateNumber?.contains(titleLower) ||
        modelName?.contains(titleLower);
    return matchesType && matchesRegion && matchesSearchTerm;
  }).toList();
}

List<dynamic>? filterSCopy(
  List<dynamic> jsonData,
  String? status,
  String? searchTerm,
) {
  final titleLower = searchTerm?.toLowerCase();
  return jsonData.where((item) {
    final equipment = item["equipment"]?.toLowerCase() ?? '';
    final title = item["title"]?.toLowerCase() ?? '';
    final license = item["license_plate_number"]?.toLowerCase() ?? '';

    bool matchesRegion = status == '' || item['status'] == status;
    bool matchesSearchTerm = searchTerm == '' ||
        equipment?.contains(titleLower) ||
        title?.contains(titleLower) ||
        license?.contains(titleLower);
    return matchesRegion && matchesSearchTerm;
  }).toList();
}

List<dynamic>? filterSearchedRemont(
  List<dynamic> jsonData,
  String title,
) {
  final titleLower = title.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["equipment"]?["title"]?.toLowerCase() ?? '';
    final modelName =
        item["equipment"]?["license_plate_number"]?.toLowerCase() ?? '';

    return brandName.contains(titleLower) || modelName.contains(titleLower);
  }).toList();
}

List<dynamic>? maintenanceSearch(
  List<dynamic> jsonData,
  String title,
) {
  final titleLower = title.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["equipment"]["title"]?.toLowerCase() ?? '';
    final modelName =
        item["equipment"]["license_plate_number"]?.toLowerCase() ?? '';

    return brandName.contains(titleLower) || modelName.contains(titleLower);
  }).toList();
}

String findWithIndexFromList(
  List<String> listt,
  int index,
) {
  return listt[index];
}

List<dynamic>? filterSearchedNaryad(
  List<dynamic> jsonData,
  String title,
) {
  final titleLower = title.toLowerCase();
  return jsonData.where((item) {
    final modelName = item["title"]?.toLowerCase() ?? '';

    return modelName.contains(titleLower);
  }).toList();
}

int? findWithIndexFromINTList(
  List<dynamic> listt,
  int index,
) {
  return listt[index];
}

dynamic findWithIndexFromListJson(
  List<dynamic> listt,
  int index,
) {
  return listt[index];
}

int plus(
  int a,
  int b,
) {
  return a + b;
}

List<dynamic> findJsonByEquipment(
  String idd,
  List<dynamic> jsonData,
) {
  return jsonData.where((item) => item["license_plate_number"] == idd).toList();
}

List<dynamic>? filterDrivers(
  List<dynamic> jsonData,
  String? searchTerm,
) {
  final titleLower = searchTerm?.toLowerCase();
  return jsonData.where((item) {
    final brandName = item["name"]?["first"]?.toLowerCase() ?? '';
    final modelName = item["name"]?["last"]?.toLowerCase() ?? '';

    bool matchesSearchTerm = searchTerm == '' ||
        brandName?.contains(titleLower) ||
        modelName?.contains(titleLower);
    return matchesSearchTerm;
  }).toList();
}

dynamic stringToJson(String jsonString) {
  return jsonDecode(jsonString);
}

dynamic findJsonByIDCopy(
  String idd,
  List<dynamic> jsonData,
) {
  try {
    // Используем firstWhere для поиска элемента с нужным id
    return jsonData.firstWhere((json) => json['id'] == idd,
        orElse: () => null // Возвращаем null, если элемент не найден
        );
  } catch (e) {
    // Обрабатываем исключение, если что-то пошло не так
    print('Error: $e');
    return null;
  }
}

dynamic deleteJsonByKey(
  List<dynamic> list,
  int value,
) {
  // Проверяем, найден ли элемент

  // Если элемент найден, удаляем его
  print(list);
  list.removeAt(value);
  print(list);
  return list;
}

List<dynamic> filterUnfinishedInspections(List<dynamic> jsonData) {
  return jsonData.where((item) => item["finished_on"] == null).toList();
}

List<dynamic> filterEquipments(
  List<dynamic> jsonData,
  String idd,
) {
  return jsonData.where((item) => item["id"] == idd).toList();
}

dynamic findJsonByID(
  int idd,
  List<dynamic> jsonData,
) {
  try {
    // Используем firstWhere для поиска элемента с нужным id
    return jsonData.firstWhere((json) => json['id'] == idd,
        orElse: () => null // Возвращаем null, если элемент не найден
        );
  } catch (e) {
    // Обрабатываем исключение, если что-то пошло не так
    print('Error: $e');
    return null;
  }
}

String roleToRus(String text) {
  if (text == 'operational_duty') {
    return "Оперативный дежурный";
  } else if (text == 'engineer') {
    return "Инженер";
  } else if (text == 'head') {
    return "Начальник";
  } else if (text == 'electrician') {
    return "Электрослесарь";
  } else if (text == 'electrician_underground') {
    return "Подземный электрослесарь";
  } else if (text == 'lead_engineer') {
    return "Ведущий инженер";
  } else {
    return text;
  }
}

List<dynamic> notNewDefects(List<dynamic> jsonData) {
  return jsonData.where((item) => item["status"] != "new").toList();
}

List<dynamic> filterChildEquips(
  List<dynamic> jsonData,
  int parentId,
) {
  return jsonData.where((item) {
    // Получаем словарь parent_info и сравниваем его элемент parentId с заданным parentId
    if (item.containsKey('parent_info') &&
        item['parent_info'] is Map<String, dynamic>) {
      return item['parent_info']['id'] == parentId;
    }
    return false; // Если нет ключа parent_info или он не соответствует структуре, возвращаем false
  }).toList();
}

DateTime? stringToDateTime(String date) {
  try {
    // Пробуем преобразовать строку в DateTime
    return DateTime.parse(date);
  } catch (e) {
    // В случае ошибки выводим информацию об ошибке и возвращаем null
    print('Error parsing date string: $e');
    return null;
  }
}

DateTime? dateTimeNow() {
  return DateTime.now();
}

bool imageNull(dynamic input) {
  const List<Map<String, dynamic>> targets = [
    {
      'data': "data:image/jpeg;base64,",
      'extension': 'jpeg',
      'size': 0,
      'title': null
    },
    {
      'data': "data:image/png;base64,",
      'extension': 'png',
      'size': 0,
      'title': null
    },
    {
      'data': "data:image/gif;base64,",
      'extension': 'gif',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/mp4;base64,",
      'extension': 'mp4',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/mov;base64,",
      'extension': 'mov',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/avi;base64,",
      'extension': 'avi',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/mkv;base64,",
      'extension': 'mkv',
      'size': 0,
      'title': null
    },
    {
      'data': 'data:application/octet-stream;base64,',
      'extension': "",
      'size': "",
      'title': ""
    },
  ];

  // Проверяем, что input — Map (любой)
  if (input is! Map) return false;

  // Приводим к Map<String, dynamic> (если ключи не String — выбросит, но у тебя ключи String)
  final Map<String, dynamic> inputMap = Map<String, dynamic>.from(input);

  // Сравниваем с каждым шаблоном
  for (final target in targets) {
    if (inputMap.length != target.length) continue;

    var isEqual = true;
    for (final key in target.keys) {
      if (!inputMap.containsKey(key)) {
        isEqual = false;
        break;
      }

      final v1 = inputMap[key];
      final v2 = target[key];

      // Если строки — можно сравнить с trim() на случай лишних пробелов:
      if (v1 is String && v2 is String) {
        if (v1.trim() != v2.trim()) {
          isEqual = false;
          break;
        }
      } else {
        if (v1 != v2) {
          isEqual = false;
          break;
        }
      }
    }

    if (isEqual) return true;
  }

  return false;
}

List<dynamic>? extractResponses(
  List<dynamic> jsonData,
  int index,
) {
  // Проверяем, что индекс находится в пределах диапазона списка
  if (index >= 0 && index < jsonData.length) {
    var item = jsonData[index];
    if (item.containsKey('responses')) {
      return item[
          'responses']; // Возвращаем список responses, если он существует
    }
  }
  return null; // Возвращаем null, если индекс вне диапазона или нет ключа 'responses'
}

String? imageNullList() {
  List<String> encodedFiles = [];
  Map<String, dynamic> newJson = {
    'data': "data:image/jpeg;base64,",
    'extension': 'jpg',
    'size': 0, // размер файла равен длине массива байтов
    'title': null
  };

  String finalJsonString = jsonEncode(newJson);
  print(finalJsonString);
  encodedFiles.add(finalJsonString);
  return encodedFiles.toString();
}

List<dynamic> filterFixedDefect(dynamic jsonData) {
  return jsonData.where((item) => item["status"] == "APPROVED").toList();
}

dynamic sortUsers(
  dynamic jsonData,
  int departmentId,
) {
  var filteredData = (jsonData['data'] as List)
      .where((item) => item['department'] == departmentId)
      .toList();
  return {'data': filteredData};
}

bool hasStuff(
  dynamic jsonData,
  int? departmentId,
) {
  var filteredData = (jsonData['data'] as List)
      .where((item) => item['department'] == departmentId)
      .toList();

  return filteredData
      .isNotEmpty; // Return true if filtered list is not empty, false otherwise.
}

int newDefectsSum(dynamic jsonData) {
  var filteredData =
      (jsonData as List).where((item) => item['status'] == 'NEW').toList();

  return filteredData.length;
}

List<dynamic> newDefects(dynamic jsonData) {
  return jsonData.where((item) => item["status"] == "NEW").toList();
}

List<dynamic> filterdoprasxody(
  List<dynamic> jsonData,
  String technic,
) {
  return jsonData.where((item) => item["technic"] == technic).toList();
}

List<dynamic> findResponsesByEquipment(
  List<dynamic> jsonData,
  int equipmentId,
) {
  List<dynamic> foundResponses = [];

  for (var item in jsonData) {
    if (item['responses'] != null) {
      List<dynamic> responses = [];
      for (var response in item['responses']) {
        if (response['regulation_work_info'] != null &&
            response['regulation_work_info']['equipment_info'] != null &&
            response['regulation_work_info']['equipment_info']['id'] ==
                equipmentId) {
          responses.add(response);
          break; // Остановка поиска, если оборудование найдено в данном осмотре
        }
      }
      if (responses.isNotEmpty) {
        var newItem =
            Map<String, dynamic>.from(item); // Создание копии элемента
        newItem['responses'] = responses;
        foundResponses.add(newItem);
      }
    }
  }

  return foundResponses;
}

List<dynamic> filterInspectionsByTitle(
  List<dynamic> data,
  String title,
) {
  return data
      .where((item) => item['regulation_info']['title'] == title)
      .toList();
}

List<dynamic> findUniqueRegulationAndEquipmentTitles(List<dynamic> data) {
  Set<String> uniqueTitles = Set();

  // Создаем список для хранения данных с уникальными заголовками
  List<dynamic> uniqueInspections = [];

  // Проходим по всем осмотрам
  for (var inspection in data) {
    var title = inspection['regulation_info']['title'];

    // Проверяем, есть ли этот заголовок в множестве уникальных заголовков
    if (!uniqueTitles.contains(title)) {
      // Если заголовка еще нет, добавляем его в множество уникальных заголовков
      uniqueTitles.add(title);

      // Добавляем данные с этим уникальным заголовком в список уникальных данных
      uniqueInspections.add(inspection);
    }
  }
  return uniqueInspections;
}

String checkInspectionStatus(
  String availableFrom,
  String availableTo,
) {
  DateTime now = DateTime.now();
  DateTime from = DateTime.parse(availableFrom);
  DateTime to = DateTime.parse(availableTo);

  if (now.isBefore(from)) {
    return "Запланировано";
  } else if (now.isAfter(from) && now.isBefore(to)) {
    return "Текущее";
  } else {
    return "Просрочено";
  }
}

dynamic findJsonElementByID(
  List<dynamic> jsonData,
  int id,
) {
  for (var item in jsonData) {
    if (item['id'] == id) {
      return item; // Return the matching element
    }
  }
  return null;
}

bool isJsonInList(
  int searchId,
  List<dynamic> jsonList,
) {
  for (var item in jsonList) {
    if (item['id'] == searchId) {
      return true;
    }
  }
  return false;
}

String? statusToRuss(String? status) {
  if (status == 'workable') {
    return 'Работоспособное';
  } else if (status == 'unworkable') {
    return 'Нерабоспособное';
  } else if (status == 'critical') {
    return 'Предельное';
  } else {
    return null;
  }
}

List<String> toOneList(
  List<String> list1,
  List<String> list2,
  List<String> list3,
) {
  List<String> combinedList = [];
  combinedList.addAll(list1);
  combinedList.addAll(list2);
  combinedList.addAll(list3);
  return combinedList;
}

String? statusMaintenance(String? status) {
  if (status == 'SOON') {
    return 'Скоро';
  } else if (status == 'EXPIRED') {
    return 'Просрочен';
  } else if (status == 'UPCOMING') {
    return 'Предстоящие';
  } else if (status == 'MISSED') {
    return 'Пропущенные';
  } else {
    return 'Выполнен';
  }
}

List<dynamic> searchEngine(
  List<dynamic> jsonList,
  String input,
) {
  final inputLower = input.toLowerCase();
  return jsonList.where((equipment) {
    // Ищем совпадения по имени бренда и гос номеру
    final brandName = equipment['brand_id']['name'].toLowerCase();
    final licensePlateNumber = equipment['license_plate_number'].toLowerCase();

    return brandName.contains(inputLower) ||
        licensePlateNumber.contains(inputLower);
  }).toList();
}

List<String> uniqueValue(List<String> inputList) {
  Set<String> uniqueSet = Set<String>.from(inputList);

  // Преобразуем Set обратно в List и возвращаем
  return uniqueSet.toList();
}

String activeOrNot(String? string) {
  if (string == 'Активный') {
    return 'ACTIVE';
  } else {
    return '';
  }
}

String? statusNaryads(String? status) {
  if (status == 'IN_PROGRESS') {
    return 'В работе';
  } else if (status == 'NEW') {
    return 'Запланирован';
  } else if (status == 'PAUSED') {
    return 'Приостановлен';
  } else if (status == 'FINALIZED') {
    return 'Завершена';
  } else if (status == 'ACCEPTOR_REJECTED') {
    return 'Отклонен';
  } else if (status == 'ON_ACCEPTOR_REVIEW') {
    return 'На приемке';
  } else {
    return 'Ошибка';
  }
}

DateTime? stringToDate(String input) {
  // 1. Проверяем на null, пустоту и ТИРЕ
  if (input == null || input.isEmpty || input == '-') {
    return null; // Возвращаем null, виджет просто покажет дефолтное значение
  }

  try {
    // 2. Пробуем распарсить
    return DateTime.parse(input);
  } catch (e) {
    // 3. Если формат кривой — не крашим приложение, а возвращаем null
    return null;
  }
}

LatLng formattedLatLon(
  String lat,
  String lon,
) {
  double latitude = double.parse(lat);
  double longitude = double.parse(lon);
  return LatLng(latitude, longitude);
}

int mileageround(String numberStr) {
// Преобразуем строку в число с плавающей запятой
  double number = double.parse(numberStr);
  // Округляем число до целого
  int roundedNumber = number.round();
  // Делим округленное число на 1000
  int dividedNumber = roundedNumber ~/ 1000; // Используем целочисленное деление
  return dividedNumber;
}

String? formatMileage(String? numberStr) {
  if (numberStr == null) {
    return null;
  }

  try {
    // Преобразуем строку в число с плавающей точкой
    double number = double.parse(numberStr.replaceAll(',', '.'));

    // Делим число на 1000
    double dividedNumber = number / 1000;

    // Форматируем число с двумя знаками после запятой
    String formattedNumber = dividedNumber.toStringAsFixed(2);

    return formattedNumber;
  } catch (e) {
    return '-';
  }
}

String gpsorroot(String input) {
  if (input != "GPS") {
    return 'Вручную';
  } else {
    return 'GPS';
  }
}

String? statusToRemontTMC(String? status) {
  if (status == 'DELIVERED') {
    return 'Доставлено';
  } else if (status == 'PURCHASED') {
    return 'Закуплено';
  } else if (status == 'IN_PROGRESS') {
    return 'На закуп';
  } else {
    return 'Нету в наличии';
  }
}

String? statussklad(String? status) {
  if (status == 'CHECKED') {
    return 'В обработке зав. склада';
  } else {
    return 'Отправлена на закуп';
  }
}

String kmorhours(String input) {
  if (input == 'ENGINE_TIME') {
    return 'ч';
  } else {
    return 'км';
  }
}

List<dynamic> jsonToList(dynamic jsonData) {
  return jsonData != null ? jsonData.toList() : [];
}

String? statuszakup(String? status) {
  if (status == 'IN_PROGRESS' ||
      status == 'WAITING_FOR_PURCHASE' ||
      status == 'PURCHASED') {
    return 'В обработке';
  } else {
    return 'Закуплено';
  }
}

String? statusready(String? status) {
  if (status == 'READY_FOR_ISSUE') {
    return 'В обработке';
  } else {
    return 'Выполнено';
  }
}

List<dynamic> findUniqueProgramAndRemainder(List<dynamic> data) {
  Set<String> uniqueKeys = Set();

  // Создаем список для хранения данных с уникальными заголовками
  List<dynamic> uniqueTasks = [];

  // Проходим по всем задачам
  for (var task in data) {
    var programTitle = task['program']['title'];
    var remainder = task['remainder'];

    // Создаем уникальный ключ для комбинации program.title и remainder
    var uniqueKey = '$programTitle|$remainder';

    // Проверяем, есть ли этот ключ в множестве уникальных ключей
    if (!uniqueKeys.contains(uniqueKey)) {
      // Если ключа еще нет, добавляем его в множество уникальных ключей
      uniqueKeys.add(uniqueKey);

      // Добавляем данные с этим уникальным ключом в список уникальных данных
      uniqueTasks.add(task);
    }
  }
  return uniqueTasks;
}

List<dynamic> maintenancedetailed(
  List<dynamic> data,
  String filterProgramTitle,
  String filterRemainder,
) {
  return data
      .where((item) =>
          item['program']['title'] == filterProgramTitle &&
          item['remainder'] == filterRemainder)
      .toList();
}

dynamic listwithoutbrackets(List<dynamic> dataList) {
  Map<String, dynamic> result = {};

  for (var item in dataList) {
    String title = item['title'];
    result[title] = {
      "title": item['title'],
      "product_article": item['product_article'],
      "nomenclature_number": null, // Добавляем ключ с null значением
      "quantity": item['quantity']
    };
  }

  return result;
}

List<String> combineNamesAndSurnames(
  List<String> names,
  List<String> surnames,
) {
  List<String> fullNames = [];

  for (int i = 0; i < names.length; i++) {
    fullNames.add('${names[i]} ${surnames[i]}');
  }

  return fullNames;
}

List<dynamic> addPriceToItems(
  List<dynamic> items,
  double price,
) {
  return items.map((item) {
    return {
      ...item,
      'price': price,
    };
  }).toList();
}

List<dynamic> mapToList(dynamic data) {
  return data.entries.map((entry) {
    return {"title": entry.key, ...entry.value};
  }).toList();
}

dynamic vnalichi(
  dynamic itemsRequested,
  dynamic itemsOutOfStock,
) {
  dynamic updatedMap = Map.from(itemsRequested);

  updatedMap.forEach((key, value) {
    int requestedQuantity = value["quantity"] ?? 0;
    int outOfStockQuantity = itemsOutOfStock[key]?["quantity"] ?? 0;

    // Обновляем только поле "quantity" в копии карты
    updatedMap[key] = Map.from(value);
    updatedMap[key]!["quantity"] = requestedQuantity - outOfStockQuantity;
  });

  return updatedMap;
}

dynamic updateItems(dynamic items) {
  dynamic updatedItems = {};

  items.forEach((key, value) {
    updatedItems[key] = {
      "quantity": 0,
      "price": 0,
      "status": "OUT_OF_STOCK",
      "approximate_delivery_date": null,
      "delivered_at": null
    };
  });

  return updatedItems;
}

int stringtoint(String? input) {
  if (input == null || input.isEmpty) {
    return 0;
  }
  // tryParse вернет null вместо ошибки, если в строке будет мусор
  return int.tryParse(input) ?? 0;
}

String substract(
  String var1,
  String var2,
) {
  int number1 = int.parse(var1);
  int number2 = int.parse(var2);
  int result = number1 - number2;
  return result.toString();
}

double? kobeitu(
  String? var1,
  String? var2,
) {
  if (var1 == null || var2 == null) return null;

  final num1 = double.tryParse(var1.trim());
  final num2 = double.tryParse(var2.trim());

  if (num1 == null || num2 == null) return null;

  return num1 * num2;
}

String? rolesId(dynamic json) {
  // Получаем объект ролей
  Map<String, dynamic> roles = json['user']['roles'];

  // Проходим по всем ключам в объекте ролей
  for (var value in roles.values) {
    // Возвращаем первый найденный roleId
    return value[0];
  }

  // Если roles пустой, возвращаем null
  return null;
}

int divideUntilLessThanThousand(int number) {
  int itemsPerPage = 10; // Количество элементов на странице
  int totalPages = (number / itemsPerPage).ceil(); // Округление вверх

  return totalPages;
}

List<dynamic> transformDataColumnAssignee(
  List<dynamic> originalData,
  List<String> sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "column_assignees": sectorIdInput,
      "work_type_id": item["work_type"]?["id"],
      "equipment_release": item["equipment_release"],
      "created_at": formattedDate
    };
  }).toList();
}

List<dynamic> transformDataProject(
  List<dynamic> originalData,
  String sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": sectorIdInput,
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "column_assignees": item["column_assignees"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "equipment_release": item["equipment_release"],
      "work_type_id": item["work_type"]?["id"],
      "created_at": formattedDate
    };
  }).toList();
}

List<dynamic> transformDataExpStatus(
  List<dynamic> originalData,
  String expstatus,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": expstatus,
      "location": item["location"],
      "column_assignees": item["column_assignees"],
      "work_type_id": item["work_type"]?["id"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "equipment_release": item["equipment_release"],
      "comment": item["comment"],
      "created_at": formattedDate
    };
  }).toList();
}

List<dynamic> transformDataTechStatus(
  List<dynamic> originalData,
  String techstatus,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": techstatus,
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "column_assignees": item["column_assignees"],
      "work_type_id": item["work_type"]?["id"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "equipment_release": item["equipment_release"],
      "created_at": formattedDate
    };
  }).toList();
}

dynamic findLocation(
  double lat,
  double lon,
  List<dynamic> locations,
) {
  // Вспомогательная функция для парсинга строковых координат в массив чисел
  for (var location in locations) {
    // Получаем строку с точками и разбиваем её на список строк
    List<String> pointsList = (location['points'] as String).split(' ');

    // Преобразуем список строк в список пар координат
    for (int i = 0; i < pointsList.length - 1; i += 2) {
      double pointLat = double.parse(pointsList[i]);
      double pointLon = double.parse(pointsList[i + 1]);

      // Сравниваем введённые координаты с каждой парой
      if (pointLat == lat && pointLon == lon) {
        return location; // Возвращаем объект с найденной локацией
      }
    }
  }

  return null;
}

bool containsString(
  List<String> stringList,
  String searchString,
) {
  return stringList.contains(searchString);
}

List<dynamic> transformDataVDO(
  List<dynamic> originalData,
  String sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "vdo": sectorIdInput,
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "column_assignees": item["column_assignees"],
      "work_type_id": item["work_type"]?["id"],
      "equipment_release": item["equipment_release"],
      "created_at": formattedDate
    };
  }).toList();
}

List<dynamic> transformDataInsStatus(
  List<dynamic> originalData,
  String sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": sectorIdInput,
      "comment": item["comment"],
      "column_assignees": item["column_assignees"],
      "work_type_id": item["work_type"]?["id"],
      "equipment_release": item["equipment_release"],
      "created_at": formattedDate
    };
  }).toList();
}

List<dynamic> transformData(
  List<dynamic> originalData,
  String sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": sectorIdInput,
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "column_assignees": item["column_assignees"],
      "work_type_id": item["work_type"]?["id"],
      "equipment_release": item["equipment_release"],
      "created_at": formattedDate
    };
  }).toList();
}

List<dynamic> emptyList() {
  return [];
}

String? getTitleById(
  List<dynamic> data,
  String id,
) {
  for (var item in data) {
    if (item['id'] == id) {
      // Возвращаем полное имя в формате "First Last"
      return "${item['name']['first']} ${item['name']['last']}";
    }
  }
  // Если id не найден, возвращаем null
  return null;
}

String? daysBetweenDates(DateTime? secondDate) {
  if (secondDate == null) {
    return "";
  }

  // Обнуляем время в обеих датах, чтобы учитывать только дату
  DateTime today = DateTime.now();
  DateTime todayAtMidnight = DateTime(today.year, today.month, today.day);
  DateTime secondDateAtMidnight =
      DateTime(secondDate.year, secondDate.month, secondDate.day);

  // Вычисляем разницу в днях между датами без учёта времени
  int difference = secondDateAtMidnight.difference(todayAtMidnight).inDays;

  // Если разница 0, то это сегодня, выводим "Осталось 0 дней"
  if (difference == 0) {
    return "Осталось 0 дней";
  }
  // Если разница больше 0, то выводим, сколько осталось
  else if (difference > 0) {
    return "Осталось $difference дней";
  }
  // Если разница меньше 0, то выводим, сколько прошло
  else {
    return "Прошло ${difference.abs()} дней";
  }
}

List<dynamic> transformDataComment(
  List<dynamic> originalData,
  String sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project_id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "column_assignees": item["column_assignees"],
      "vdo": item["vdo"],
      "inspection_date": item["inspection_date"],
      "inspection_status": item["inspection_status"],
      "comment": sectorIdInput,
      "equipment_release": item["equipment_release"],
      "work_type_id": item["work_type"]?["id"],
      "created_at": formattedDate
    };
  }).toList();
}

DateTime? addDaysToDate(
  DateTime firstDate,
  int n,
) {
  return firstDate.add(Duration(days: n));
}

List<dynamic> transformDataInspectionDate(
  List<dynamic> originalData,
  String sectorIdInput,
) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(DateTime.now());
  return originalData.map((item) {
    return {
      "equipment_id": item["equipment_id"],
      "sector_id": item["sector"]?["id"],
      "project_id": item["project"]?["id"],
      "drivers": item["drivers"],
      "responsible_employees": item["responsible_employees"]
          ?.map((employee) => employee["id"])
          ?.toList(),
      "technical_status": item["technical_status"],
      "exploitation_status": item["exploitation_status"],
      "location": item["location"],
      "vdo": item["vdo"],
      "inspection_date": sectorIdInput,
      "inspection_status": item["inspection_status"],
      "comment": item["comment"],
      "column_assignees": item["column_assignees"],
      "work_type_id": item["work_type"]?["id"],
      "equipment_release": item["equipment_release"],
      "created_at": formattedDate
    };
  }).toList();
}

bool equipmentInList(
  String equipmentId,
  List<dynamic> jsonList,
) {
  try {
    // Парсим JSON-строку в список

    // Проверяем, содержит ли список объект с заданным equipment_id
    return jsonList.any((item) => item['equipment_id'] == equipmentId);
  } catch (e) {
    // Возвращаем false, если произошла ошибка
    return false;
  }
}

List<dynamic> changeProject(
  List<dynamic> jsonList,
  List<String> equipmentIds,
  String periodFrom,
  String periodTo,
) {
  for (String equipmentId in equipmentIds) {
    jsonList.add({
      "id": equipmentId,
      "period_from": periodFrom,
      "period_to": periodTo,
    });
  }

  // Возвращаем обновлённый список
  return jsonList;
}

String plusOne(String input) {
  try {
    int currentValue = int.parse(input);
    return (currentValue + 1).toString();
  } catch (e) {
    // Если преобразование не удалось, вернуть исходную строку
    return input;
  }
}

String encodeToUrlComponent(String input) {
  return Uri.encodeComponent(input);
}

int getAclValue(
  dynamic jsonData,
  String apiPath,
) {
  if (jsonData.containsKey("acl") && jsonData["acl"].containsKey(apiPath)) {
    List<dynamic> aclList = jsonData["acl"][apiPath];
    if (aclList.isNotEmpty) {
      Map<String, dynamic> aclEntry = aclList.first;
      return aclEntry.values.first;
    }
  }
  return 111;
}

String trimLeadingSpaces(String text) {
  return text.replaceFirst(RegExp(r'^\s+'), '');
}

String roleId(dynamic roles) {
  return roles.values.first[0];
}

String getFileExtension(String url) {
  Uri uri = Uri.parse(url);
  String path = uri.path;

  if (path.contains('.')) {
    return path.split('.').last;
  }
  return '';
}

bool ifnulltofalse(bool? value) {
  if (value == null) {
    return false;
  } else {
    return value;
  }
}

DateTime? addgmt5(DateTime? dateTime) {
  return dateTime?.add(Duration(hours: 5));
}

bool nameInList(
  List<dynamic> assignees,
  String name,
) {
  return assignees.any((assignee) => assignee["title"]?.trim() == name.trim());
}

bool isReversedNameMatch(
  String fullName,
  String nameToCheck,
) {
  List<String> fullNameParts = fullName.trim().split(RegExp(r'\s+'));
  List<String> nameToCheckParts = nameToCheck.trim().split(RegExp(r'\s+'));

  return Set.from(fullNameParts).containsAll(nameToCheckParts);
}

List<dynamic> filterBrandsByClassificationId(
  List<dynamic> jsonList,
  String targetId,
) {
  return jsonList
      .where((item) => item['classification_id'] == targetId)
      .toList();
}

double? stringtodouble(String? value) {
  if (value == null || value.isEmpty) return null;
  return double.tryParse(value);
}

String sumNumbersInStringList(List<dynamic>? data) {
  double totalSum = 0.0;

  if (data == null) {
    return totalSum.toString(); // или "0.0"
  }

  for (var item in data) {
    if (item is num) {
      totalSum += item.toDouble();
    } else if (item is Map) {
      for (var value in item.values) {
        if (value is num) {
          totalSum += value.toDouble();
        }
      }
    }
  }

  return totalSum.toString();
}

List<String> getUniqueBrands(dynamic inputJson) {
  final Set<String> seenNormalized = {};
  final List<String> uniqueBrands = [];

  for (var item in inputJson) {
    if (item is String) {
      final normalized = item.trim().toLowerCase();
      if (!seenNormalized.contains(normalized)) {
        seenNormalized.add(normalized);
        uniqueBrands
            .add(item.trim()); // сохраняем оригинал с нормализованным пробелом
      }
    }
  }

  return uniqueBrands;
}

String extractFileName(String url) {
  try {
    // Убираем кавычки и пробелы по краям
    url = url.replaceAll('"', '').trim();

    // Получаем только имя файла
    final fileName = url.split('/').last;

    // Убираем расширение .pdf (без учёта регистра)
    final withoutExtension =
        fileName.replaceAll(RegExp(r'\.pdf$', caseSensitive: false), '');

    // Убираем ID до дефиса (если он есть)
    final dashIndex = withoutExtension.indexOf('-');
    if (dashIndex != -1) {
      return withoutExtension.substring(dashIndex + 1).trim();
    }

    return withoutExtension.trim();
  } catch (e) {
    return 'Файл';
  }
}

String roundToTwoDecimals(num? value) {
  if (value == null) return "0.00"; // Обработка null

  // Создаем форматтер: 
  // #,###.00 — разделяет тысячи и всегда оставляет 2 знака после запятой
  // .replaceAll(',', ' ') — меняет американскую запятую на пробел
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(value).replaceAll(',', ' ');
}

String addOne(int num1) {
  int sum = (num1 + 1);
  return sum.toString();
}

bool checkLogicTrigger(dynamic json) {
  try {
    // Преобразуем dynamic в Map, если это строка
    final data = json is String ? jsonDecode(json) : json;

    // Извлекаем список значений logics[:].value
    final logics = (data['logics'] ?? []) as List;

    final logicValues = logics
        .map((e) => e['value'])
        .where((v) => v != null)
        .map((v) => v.toString())
        .toList();

    // Извлекаем первый ответ пользователя
    final answers = (data['answers'] ?? []) as List;
    final answer = answers.isNotEmpty ? answers.first.toString() : '';

    // Проверяем, содержится ли ответ в значениях логики
    return logicValues.contains(answer);
  } catch (e) {
    print('checkLogicTrigger error: $e');
    return false;
  }
}

String removeBase64Prefix(String base64Data) {
  const prefixes = [
    'data:image/png;base64,',
    'data:image/jpeg;base64,',
  ];

  for (final prefix in prefixes) {
    if (base64Data.startsWith(prefix)) {
      return base64Data.replaceFirst(prefix, '');
    }
  }

  return base64Data;
}

List<dynamic> removeAtIndex(
  List<dynamic> jsonData,
  int structureIndex,
  int questionIndex,
  int commentIndex,
  String what,
) {
  bool updated = false;

  try {
    // Проверяем, что нужный раздел существует
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем, что нужный вопрос существует
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          // Проверяем, что у вопроса есть комментарии
          if (question.containsKey(what) && question[what] != null) {
            var comments = question[what];

            // Проверяем, что нужный комментарий существует
            if (commentIndex >= 0 && commentIndex < comments.length) {
              var removedComment = comments.removeAt(commentIndex);
              print('✅ Комментарий "$removedComment" успешно удалён.');
              updated = true;
            } else {
              print('❌ Некорректный commentIndex: $commentIndex');
            }
          } else {
            print('⚠️ У вопроса нет поля comments');
          }
        } else {
          print('❌ Некорректный questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Некорректный structureIndex: $structureIndex');
    }

    if (!updated) {
      print('🚫 Комментарий не был удалён.');
    }
  } catch (e) {
    print('⚠️ Ошибка при удалении комментария: $e');
  }

  // Возвращаем обновлённый JSON
  return jsonData;
}

List<dynamic> addDefectAtIndex(
  List<dynamic> jsonData,
  int structureIndex,
  int questionIndex,
  String what,
  DefectsStruct defect,
) {
  bool updated = false;

  try {
    // Проверяем существование раздела
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем существование вопроса
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          // Проверяем наличие нужного поля (например defects или comments)
          if (question.containsKey(what)) {
            // Если поле уже есть, убеждаемся, что это список
            if (question[what] is List) {
              question[what].add(defect.toMap());
            } else {
              // Если по ошибке не список, заменяем на список
              question[what] = [defect.toMap()];
            }
          } else {
            // Если поля нет — создаём новое
            question[what] = [defect.toMap()];
          }

          updated = true;
          print('✅ Дефект успешно добавлен в поле "$what".');
        } else {
          print('❌ Некорректный questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Некорректный structureIndex: $structureIndex');
    }

    if (!updated) {
      print('🚫 Дефект не был добавлен.');
    }
  } catch (e) {
    print('⚠️ Ошибка при добавлении дефекта: $e');
  }

  // Возвращаем обновлённый JSON
  return jsonData;
}

List<dynamic> addFilesAtIndex(
  List<dynamic> jsonData,
  int structureIndex,
  int questionIndex,
  String what,
  dynamic defect,
) {
  bool updated = false;

  try {
    // Проверяем существование раздела
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем существование вопроса
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          // Проверяем наличие нужного поля (например defects или comments)
          if (question.containsKey(what)) {
            // Если поле уже есть, убеждаемся, что это список
            if (question[what] is List) {
              question[what].add(defect);
            } else {
              // Если по ошибке не список, заменяем на список
              question[what] = [defect];
            }
          } else {
            // Если поля нет — создаём новое
            question[what] = [defect];
          }

          updated = true;
          print('✅ Дефект успешно добавлен в поле "$what".');
        } else {
          print('❌ Некорректный questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Некорректный structureIndex: $structureIndex');
    }

    if (!updated) {
      print('🚫 Дефект не был добавлен.');
    }
  } catch (e) {
    print('⚠️ Ошибка при добавлении дефекта: $e');
  }

  // Возвращаем обновлённый JSON
  return jsonData;
}

List<dynamic> updateAtIndex(
  List<dynamic> jsonData,
  int structureIndex,
  int questionIndex,
  String input,
  String what,
) {
  bool updated = false;

  try {
    // Проверяем, что нужный раздел существует
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем, что нужный вопрос существует
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          // Проверяем или создаём поле answers
          if (question[what] == null || question[what] is! List) {
            question[what] = [];
          }

          // Обновляем answers — перезаписываем новым значением
          question[what] = [input];
          updated = true;

          print('✅ Обновлено поле "$what" у вопроса на значение "$input".');
        } else {
          print('❌ Некорректный questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Некорректный structureIndex: $structureIndex');
    }

    if (!updated) {
      print('🚫 Поле не было обновлено.');
    }
  } catch (e) {
    print('⚠️ Ошибка при обновлении: $e');
  }

  // Возвращаем обновлённый JSON
  return jsonData;
}

List<dynamic> updateAtIndexList(
  List<dynamic> jsonData,
  int structureIndex,
  int questionIndex,
  List<String> input,
  String what,
) {
  bool updated = false;

  try {
    // Проверяем, что нужный раздел существует
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем, что нужный вопрос существует
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          // Проверяем, что у вопроса есть комментарии
          if (question.containsKey(what) && question[what] != null) {
            if (question[what] == null || question[what] is! List) {
              question[what] = [];
            }
            question['answers'] = input;
          } else {
            print('⚠️ У вопроса нет поля comments');
          }
        } else {
          print('❌ Некорректный questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Некорректный structureIndex: $structureIndex');
    }

    if (!updated) {
      print('🚫 Комментарий не был удалён.');
    }
  } catch (e) {
    print('⚠️ Ошибка при удалении комментария: $e');
  }

  // Возвращаем обновлённый JSON
  return jsonData;
}

List<dynamic> updateAtIndexDate(
  List<dynamic> jsonData,
  int structureIndex,
  int questionIndex,
  String date,
  String what,
  String hour,
) {
  bool updated = false;

  try {
    // Проверяем, что нужный раздел существует
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем, что нужный вопрос существует
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          // Проверяем, что у вопроса есть комментарии
          if (question.containsKey(what) && question[what] != null) {
            if (question[what] == null || question[what] is! List) {
              question[what] = [];
            }
            question['answers'] = [date, hour];
          } else {
            print('⚠️ У вопроса нет поля comments');
          }
        } else {
          print('❌ Некорректный questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Некорректный structureIndex: $structureIndex');
    }

    if (!updated) {
      print('🚫 Комментарий не был удалён.');
    }
  } catch (e) {
    print('⚠️ Ошибка при удалении комментария: $e');
  }

  // Возвращаем обновлённый JSON
  return jsonData;
}

List<String> getActionsForValue(
  dynamic logicsJson,
  int? userValue,
) {
  /// Принимает `logicsJson` (String JSON или List) и userValue (double/int)
  /// Возвращает список уникальных action-строк, например ["attach_media","add_comment"]

  if (logicsJson == null || userValue == null) return [];

  // Если пришла строка — попытаться распарсить JSON
  final dynamic logics =
      (logicsJson is String) ? jsonDecode(logicsJson) : logicsJson;

  if (logics is! List) return [];

  final Set<String> result = {};

  for (final dynamic logic in logics) {
    if (logic == null || logic is! Map) continue;
    final String type = (logic['type'] ?? '').toString();
    final List<dynamic> logicActions =
        (logic['actions'] is List) ? List.from(logic['actions']) : [];

    // Попробуем корректно получить числовые пороги
    num? cmp1;
    num? cmp2;
    try {
      if (logic['value_cmp_1'] != null &&
          logic['value_cmp_1'].toString() != '') {
        cmp1 = num.tryParse(logic['value_cmp_1'].toString());
      }
      if (logic['value_cmp_2'] != null &&
          logic['value_cmp_2'].toString() != '') {
        cmp2 = num.tryParse(logic['value_cmp_2'].toString());
      }
    } catch (_) {
      // Игнорируем парсинг ошибок и считаем пороги null
      cmp1 = null;
      cmp2 = null;
    }

    bool condition = false;

    switch (type) {
      case 'lt':
        if (cmp1 != null) condition = userValue < cmp1;
        break;
      case 'lte':
        if (cmp1 != null) condition = userValue <= cmp1;
        break;
      case 'gt':
        if (cmp1 != null) condition = userValue > cmp1;
        break;
      case 'gte':
        if (cmp1 != null) condition = userValue >= cmp1;
        break;
      case 'eq':
        if (cmp1 != null) condition = userValue == cmp1;
        break;
      case 'neq':
        if (cmp1 != null) condition = userValue != cmp1;
        break;
      case 'btw':
        if (cmp1 != null && cmp2 != null)
          condition = userValue >= cmp1 && userValue <= cmp2;
        break;
      case 'nbtw':
        if (cmp1 != null && cmp2 != null)
          condition = userValue < cmp1 || userValue > cmp2;
        break;
      default:
        // если тип неизвестен — пропустить
        condition = false;
    }

    if (condition) {
      for (final a in logicActions) {
        if (a != null) result.add(a.toString());
      }
    }
  }

  return result.toList();
}

int doubletoInt(double value) {
  return value.round();
}

double inttodouble(int value) {
  return value.toDouble();
}

List<dynamic> groupAndSumTMC(dynamic inputJson) {
  // 1. Безопасность: если пришел null
  if (inputJson == null) {
    return [];
  }

  dynamic data = inputJson;

  // 2. Декодирование: если пришла JSON-строка
  if (data is String) {
    try {
      if (data.trim().isEmpty || data == "null") return [];
      data = jsonDecode(data);
    } catch (e) {
      return [];
    }
  }

  // 3. НОРМАЛИЗАЦИЯ: Превращаем любой входной формат (Map или List) в плоский список
  List<Map<String, dynamic>> rawItems = [];

  if (data is Map) {
    // ВАЖНО: Этот блок обрабатывает оба ваших случая.
    // И {"Сцепление": ...}, и {"0": ...} являются Map.
    // Мы перебираем их содержимое.
    for (var entry in data.entries) {
      var val = entry.value;

      // Проверяем, является ли значение объектом (Map)
      if (val is Map) {
        // Создаем копию данных для безопасной работы
        Map<String, dynamic> itemData = Map<String, dynamic>.from(val);

        // ЛОГИКА НАЗВАНИЯ (TITLE):
        // 1. Сначала ищем 'title' внутри объекта (как в "Отопитель" или "Сцепление")
        // 2. Если внутри пусто, берем Ключ Map (актуально, если ключ был названием)
        if (itemData['title'] == null ||
            itemData['title'].toString().trim().isEmpty) {
          itemData['title'] = entry.key.toString();
        }

        rawItems.add(itemData);
      }
    }
  } else if (data is List) {
    // Если вдруг пришел массив (стандартный JSON массив)
    for (var item in data) {
      if (item is Map) {
        rawItems.add(Map<String, dynamic>.from(item));
      }
    }
  } else {
    // Если пришел мусор (число, bool)
    return [];
  }

  // 4. ГРУППИРОВКА И СУММИРОВАНИЕ
  // Ключ группировки: "Название|Артикул"
  Map<String, Map<String, dynamic>> groupedMap = {};

  for (var item in rawItems) {
    // Получаем данные с защитой от null
    String title = item['title']?.toString() ?? 'Без названия';
    String article = item['product_article']?.toString() ?? '';
    String status = item['status']?.toString() ?? '';

    // Создаем уникальный ключ для группы
    String uniqueKey = '$title|$article';

    // Парсим количество. Используем tryParse для безопасности (работает с "1", 1, 1.0)
    double quantity = 0.0;
    if (item['quantity'] != null) {
      quantity = double.tryParse(item['quantity'].toString()) ?? 0.0;
    }

    if (groupedMap.containsKey(uniqueKey)) {
      // ЕСЛИ ЗАПИСЬ УЖЕ ЕСТЬ -> СУММИРУЕМ КОЛИЧЕСТВО
      double currentQty =
          double.tryParse(groupedMap[uniqueKey]!['quantity'].toString()) ?? 0.0;
      groupedMap[uniqueKey]!['quantity'] = currentQty + quantity;

      // (Опционально) Можно обновлять статус, если он важен
    } else {
      // ЕСЛИ НЕТ -> СОЗДАЕМ НОВУЮ ЗАПИСЬ
      // Мы сохраняем все поля исходного объекта, но перезаписываем quantity числом
      item['quantity'] = quantity;
      // Гарантируем, что title и article строковые
      item['title'] = title;
      item['product_article'] = article;

      groupedMap[uniqueKey] = item;
    }
  }

  // 5. Возвращаем список сгруппированных объектов
  return groupedMap.values.toList();
}

List<dynamic> createApproversList(
  List<String> approverIds,
  String invoiceId,
) {
  List<Map<String, dynamic>> result = [];

  // Перебираем список ID согласующих
  for (int i = 0; i < approverIds.length; i++) {
    result.add({
      "approver_id": approverIds[i],
      "approved": null, // null, как в вашем примере
      "order": i + 1, // Порядковый номер (начиная с 1)
      "invoice_approved": [
        {
          "invoice_id": invoiceId,
          "approved": null, // null, как в вашем примере
        }
      ]
    });
  }

  return result;
}

List<dynamic> createSingleInvoiceList(
  String invoiceId,
  String name,
) {
  Map<String, dynamic> invoiceObject = {
    "invoice_id": invoiceId,
    "name": name,
    "accountant_ids": null,
    "buyer_id": null,
    "storekeeper_id": null,
    "send_to_buyer": false,
    "power_of_attorney": null,
    "payment_order": null
  };

  // Возвращаем его внутри списка
  return [invoiceObject];
}

dynamic updateItemsStatusToPurchased(dynamic itemsJson) {
// 1. Проверяем, что входные данные не null
  if (itemsJson == null) {
    return {};
  }

  // 2. Если пришла строка, парсим её в Map, иначе используем как есть
  Map<String, dynamic> inputMap;
  if (itemsJson is String) {
    try {
      inputMap = jsonDecode(itemsJson);
    } catch (e) {
      return {};
    }
  } else if (itemsJson is Map) {
    inputMap = Map<String, dynamic>.from(itemsJson);
  } else {
    return {};
  }

  // 3. Создаем новую карту для результата
  Map<String, dynamic> resultMap = {};

  // 4. Перебираем все элементы входной карты
  inputMap.forEach((key, value) {
    if (value is Map) {
      Map<String, dynamic> item = Map<String, dynamic>.from(value);

      // --- ЛОГИКА ФОРМАТИРОВАНИЯ ДАТЫ (ВСТРОЕННАЯ) ---
      String? formattedDate;
      if (item["approximate_delivery_date"] != null) {
        String dateStr = item["approximate_delivery_date"].toString();
        // Если дата заканчивается на Z и нет миллисекунд (точки), добавляем .000Z
        if (dateStr.endsWith('Z') && !dateStr.contains('.')) {
          formattedDate = dateStr.replaceFirst('Z', '.000Z');
        } else {
          formattedDate = dateStr;
        }
      }
      // ------------------------------------------------

      // 5. Формируем новый объект
      resultMap[key] = {
        "part_id": item["part_id"] ?? "",
        "quantity": item["quantity"],
        "price": item["price"],
        "approximate_delivery_date":
            formattedDate, // Используем обработанную дату
        "status": "PURCHASED", // Меняем статус на PURCHASED
        "equipment_id": item["equipment_id"] ?? "",
        "defect_id": item["defect_id"] ?? "",
        "title": item["title"] ?? "",
        "unit_of_measurement": item["unit_of_measurement"] ?? "",
        "product_article": item["product_article"] ?? "",
        "nomenclature_number": item["nomenclature_number"] ?? ""
      };
    }
  });

  // 6. Возвращаем результат в нужной обертке
  return {"items_out_of_stock": resultMap};

  // Если нужно вернуть просто содержимое items_out_of_stock:
  // return resultMap;
}
