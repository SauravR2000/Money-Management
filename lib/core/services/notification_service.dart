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

import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void backgroundNotificationResponseHandler(
    NotificationResponse notification) async {
  log('Received background notification response: $notification');
}

class NotificationService {

  // Make an object of flutter notification plugin
  final FlutterLocalNotificationsPlugin notificationPlugin = FlutterLocalNotificationsPlugin();

  /// Initialize the notification plugin.
  ///
  /// This function should be called once when the app starts. It initializes the
  /// notification plugin and sets up the necessary settings for each platform.
  ///
  /// On Android, it sets the notification icon and sets the importance of the
  /// notifications to maximum.
  ///
  /// On iOS, it requests permission for the app to display notifications and
  /// sets the default presentation options.
  ///
  /// It also sets up a handler for when a notification is tapped while the app
  /// is in the background.
  ///
  /// This function should be called before calling any other methods on the
  /// plugin.
  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationAndroidSettings = AndroidInitializationSettings('notification_icon');

    final DarwinInitializationSettings initializationSettingIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: (id, title, body, payload) async {
      //   log('Received local notification: $id, $title, $body, $payload');
      // },
    );
    
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationAndroidSettings,
      iOS: initializationSettingIOS,
    );

    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationResponseHandler,
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    log('Showing notification: $id, $title, $body, $payload');
    await notificationPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
}
