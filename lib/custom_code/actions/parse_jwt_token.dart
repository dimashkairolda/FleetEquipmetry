// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:jwt_decode/jwt_decode.dart';

Future<DateTime?> parseJwtToken(String jwtToken) async {
  try {
    Map<String, dynamic> payload = Jwt.parseJwt(jwtToken);
    int? expiration = payload['exp'];

    if (expiration != null) {
      return DateTime.fromMillisecondsSinceEpoch(expiration * 1000);
    } else {
      print('Срок действия токена не найден.');
      return null;
    }
  } catch (e) {
    print('Ошибка при расшифровке токена: $e');
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
