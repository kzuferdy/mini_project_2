import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  /// Flutter Local Notification Plugin
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Notification Payload
  static ValueNotifier<String> payload = ValueNotifier<String>('');

  /// Set the payload
  static void setPayload(String newPayload) {
    payload.value = newPayload;
  }

  /// Inisialisasikan Settingan Channel Notifikasi untuk Android
  static AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
    'local_notif_channel_id', // Channel ID
    'Local Notifications', // Channel Name
    channelDescription: 'Channel for local notifications',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    playSound: true,
    enableVibration: true,
  );

  /// Inisialisasikan Setting Channel Notifikasi untuk iOS
  static DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(
    threadIdentifier: 'local_notif_thread',
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  /// Notifications Details untuk multi platform
  static NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iOSNotificationDetails,
  );

  /// Inisialisasi flutter_local_notifications
  static Future<void> initLocalNotifications() async {
    /// Config for Android
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    /// Config for iOS & MacOS
    const initializationSettingsIOS = DarwinInitializationSettings();

    /// Initializations
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    /// Inisialisasikan Konfigurasi dari Local Notification
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint("Notifikasi Ditekan ${details.payload}");
        setPayload(details.payload ?? '');
      },
    );

    /// Request Permission untuk Android 13 ke atas
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    /// Request Permission untuk iOS
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosImplementation != null) {
      iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  /// Tampilkan notifikasi
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  /// Tampilkan notifikasi dengan payload
  static Future<void> showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
