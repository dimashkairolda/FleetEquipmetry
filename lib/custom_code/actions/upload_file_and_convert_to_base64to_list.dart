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

dynamic uploadFileAndConvertToBase64toList(FFUploadedFile uploadedFile) {
  Map<String, dynamic> fileData = jsonDecode(uploadedFile.serialize());
  List<int> bytesList = List<int>.from(fileData['bytes']);
  String base64String = base64Encode(bytesList);

  // Определяем расширение файла
  String fileName = fileData['name'] ?? '';
  String extension = '';
  String mimeType = '';

  if (fileName.contains('.')) {
    extension = fileName.split('.').last.toLowerCase();
  }

  // Определяем MIME по расширению
  switch (extension) {
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
      mimeType = 'image/$extension';
      if (extension == 'jpg') extension = 'jpeg'; // для корректного image/jpeg
      break;
    case 'mp4':
    case 'mov':
    case 'avi':
    case 'mkv':
      mimeType = 'video/$extension';
      break;
    default:
      mimeType = 'application/octet-stream'; // на всякий случай
  }

  Map<String, dynamic> newJson = {
    'data': "data:$mimeType;base64,$base64String",
    'extension': extension,
    'size': "${bytesList.length}",
    'title': fileName
  };

  return newJson;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
