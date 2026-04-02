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

String uploadFileAndConvertToBase64(FFUploadedFile uploadedFile) {
  Map<String, dynamic> imageData = jsonDecode(uploadedFile.serialize());
  List<int> bytesList = List<int>.from(imageData['bytes']);
  String base64String = base64Encode(bytesList);

  Map<String, dynamic> newJson = {
    'data': "data:image/jpeg;base64,$base64String",
    'extension': 'jpg',
    'size': bytesList.length, // размер файла равен длине массива байтов
    'title': imageData['name']
  };

  String finalJsonString = jsonEncode(newJson);
  print(finalJsonString);
  return finalJsonString;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
