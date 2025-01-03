import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkExactAlarmPermission() async {
  // if (Platform.isAndroid && (await _isExactAlarmPermissionRequired())) {
  //   final status = await Permission.systemAlertWindow.request();
  //   return status.isGranted;
  // }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool permission = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission() ??
      false;

  return permission;
}

Future<bool> _isExactAlarmPermissionRequired() async {
  // Exact alarm permission is only required on Android 12+
  if (Platform.isAndroid && (await getPlatformVersion()) >= 31) {
    final status = await Permission.systemAlertWindow.status;
    return !status.isGranted;
  }
  return false;
}

Future<int> getPlatformVersion() async {
  // Returns the Android version
  final version = await Platform.operatingSystemVersion.split(' ')[1];
  return int.tryParse(version.split('.')[0]) ?? 0;
}
