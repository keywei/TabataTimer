import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalNotifService {
  LocalNotifService._(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  static const _channelId = 'tabata_workout';

  static Future<LocalNotifService> create() async {
    final plugin = FlutterLocalNotificationsPlugin();
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: true,
    );
    await plugin.initialize(
      settings: const InitializationSettings(android: initAndroid, iOS: initIos),
    );
    return LocalNotifService._(plugin);
  }

  Future<void> showWorkoutComplete({required String title, required String body}) async {
    try {
      await _plugin.show(
        id: 1,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            'Tabata workouts',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(presentSound: true),
        ),
      );
    } catch (e) {
      if (kDebugMode) debugPrint('notif error: $e');
    }
  }
}

final localNotifServiceProvider = FutureProvider<LocalNotifService>((ref) {
  return LocalNotifService.create();
});
