import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<String?> getId() async {
   var deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidIdPlugin = const AndroidId();
    var androidId = await androidIdPlugin.getId(); // Ensure await is used
    return androidId; // Unique ID on Android
  }

  return null; // In case of unsupported platforms
}