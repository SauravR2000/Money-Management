// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('money');

//     var initializationSettingIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     var initializatoinSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingIOS,
//     );

//     await notificationsPlugin.initialize(
//       initializatoinSettings,
//       onDidReceiveNotificationResponse: (notificationResponse) async {},
//     );

//     tz.initializeTimeZones();
//   }

//   notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId',
//         'channelName',
//         importance: Importance.max,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     return notificationsPlugin.show(
//       id,
//       title,
//       body,
//       await notificationDetails(),
//     );
//   }

//   Future showPeriodicNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     return notificationsPlugin.periodicallyShow(
//       id,
//       title,
//       body,
//       RepeatInterval.daily,
//       await notificationDetails(),
//       androidScheduleMode: AndroidScheduleMode.alarmClock,
//     );
//   }

//   Future showScheduleNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//     required Duration schedulesTime,
//   }) async {
//     // final hasPermission = await checkExactAlarmPermission();
//     // log("has notification permission = $hasPermission");
//     // if (!hasPermission) {
//     //   // Show a dialog or redirect the user to the app settings
//     //   log('Exact alarm permission not granted. Redirecting to settings...');
//     //   openAppSettings();
//     //   return;
//     // }

//     notificationsPlugin.zonedSchedule(
//       0, // Notification ID
//       title ?? 'Scheduled Notification',
//       body ?? 'This notification was scheduled 10 seconds ago.',
//       tz.TZDateTime.now(tz.local).add(schedulesTime), // 10 seconds from now
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'channel_id', // Channel ID
//           'channel_name', // Channel name
//           channelDescription: 'Channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidScheduleMode: AndroidScheduleMode.exact,
//     );
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static Future init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) async {});
  }
}
