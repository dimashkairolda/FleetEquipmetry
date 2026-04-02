import 'package:Equipmetry/auth/custom_auth/auth_util.dart';
import 'package:Equipmetry/approvement/approvement_detailed/approvement_detailed_widget.dart';
import 'package:Equipmetry/backend/api_requests/api_calls.dart';
import 'package:Equipmetry/index.dart';
import 'package:Equipmetry/procurement/procurement_detailed/procurement_detailed_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
// import 'package:your_project/api/update_fcm_token_call.dart'; // раскомментируй если используешь API

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Запрашиваем разрешения
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      try {
        // Получаем токен
        final fcmToken = await _firebaseMessaging.getToken();
        if (fcmToken != null) {
          FFAppState().fcmtoken = fcmToken;
          await FirebasePostCall.call(
        access: currentAuthenticationToken,
        work: FFAppState().workspace,
        firebasetoken: fcmToken,
        userid: getJsonField(
          FFAppState().result,
          r'''$.user.id''',
        ).toString(),
      );
        }
        debugPrint('FCM Token: $fcmToken');

        // Подписка на обновление токена
        FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
          debugPrint("Обновлённый FCM Token: $newToken");
          //await _updateTokenOnServer(newToken);
        });
      } catch (e) {
        debugPrint('Ошибка получения FCM токена: $e');
      }

      // Открытие приложения из фона по тапу на пуш
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageClick);
      // Открытие приложения из полностью закрытого состояния по тапу на пуш
      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageClick(initialMessage);
      }
    } else {
      debugPrint('Пользователь не дал разрешение на уведомления.');
    }
  }

  /// Обработка нажатия на уведомление
void _handleMessageClick(RemoteMessage message) {
  final defectId = message.data['defectId'];
  final requestId = message.data['requestId'];
  final type = message.data['type'];
  final approvalId = message.data['approvalId'];
  final typeUpper = type?.toString().trim().toUpperCase();

  final context = appNavigatorKey.currentContext!;
  debugPrint(message.data.toString());

  if (defectId != null) {
    GoRouter.of(context).pushNamed(
      DetailedDefectsOfflineCopyWidget.routeName,
      queryParameters: {
        'id': defectId,
        'storehousestatus': 'null', // строка 'null', если нужно именно так
      }.withoutNulls,
    );
  } else if (approvalId != null &&
      (typeUpper == 'PROCUREMENT' || typeUpper == null || typeUpper.isEmpty)) {
    GoRouter.of(context).pushNamed(
      ApprovementDetailedWidget.routeName,
      queryParameters: {
        'id': approvalId,
      }.withoutNulls,
    );
  } else if (requestId != null && typeUpper == 'PROCUREMENT') {
    GoRouter.of(context).pushNamed(
      ProcurementDetailedWidget.routeName,
      queryParameters: {
        'id': requestId,
      }.withoutNulls,
    );
  } else if (requestId != null) {
    if (type == 'TICKET_STATUS_FINISH' || type == 'NEW_TICKET') {
      // 🔧 TODO: Действие для тикетов
      GoRouter.of(context).pushNamed(
  NaryadsOfflineWidget.routeName,
  queryParameters: {
    'json': jsonEncode({"id": requestId}),
  }.withoutNulls,
);

    } else if (type == 'ORDER_ASSIGNED') {
      // 🔧 TODO: Действие для ORDER_ASSIGNED
       GoRouter.of(context).pushNamed(
                                                  StoreHouseDetailedWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'id': requestId
                                                    
                                                  }.withoutNulls,
                                                );
    } else {
      // 🔧 Тип есть, но неизвестный — можно обработать по умолчанию
      GoRouter.of(context).pushNamed(
        CTOdetailedWidget.routeName,
        queryParameters: {
          'json': jsonEncode({"id": requestId}),
        }.withoutNulls,
      );
    }
  } else {
    // Покажем диалог, если ни defectId, ни requestId не переданы
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Ошибка'),
        content: Text('Неизвестный тип сообщения или отсутствует ID'),
      ),
    );
  }
}


    
   

  /// Отправка токена на сервер
  // Future<void> _updateTokenOnServer(String token) async {
  //   try {
  //     await FirebasePostCall.call(
  //       access: currentAuthenticationToken,
  //       userid: token,
  //       deviceid: await getId(),
  //       userId: getJsonField(FFAppState().account, r'''$.id'''),
  //     );
  //   } catch (e) {
  //     print('Ошибка отправки токена на сервер: $e');
  //   }
  // }

}
