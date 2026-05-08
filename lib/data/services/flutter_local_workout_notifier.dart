import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/services/workout_notifier.dart';

class FlutterLocalWorkoutNotifier implements WorkoutNotifier {
  FlutterLocalWorkoutNotifier._(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  static const _channelId = 'tabata_workout';
  static const _ongoingChannelId = 'tabata_workout_ongoing';
  static const _completedId = 1;
  static const _ongoingId = 2;

  static Future<FlutterLocalWorkoutNotifier> create() async {
    final plugin = FlutterLocalNotificationsPlugin();
    // Don't request iOS permission here — defer to requestPermission()
    // so the prompt timing is controlled by the app, not by plugin init.
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initIos = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await plugin.initialize(
      settings: const InitializationSettings(android: initAndroid, iOS: initIos),
    );
    return FlutterLocalWorkoutNotifier._(plugin);
  }

  @override
  Future<bool> requestPermission() async {
    try {
      if (Platform.isIOS) {
        final ios = _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        final granted = await ios?.requestPermissions(
          alert: true,
          badge: false,
          sound: true,
        );
        return granted ?? false;
      }
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        final granted = await android?.requestNotificationsPermission();
        return granted ?? true;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('notif permission error: $e');
    }
    return true;
  }

  @override
  Future<void> showCompleted({required String title, required String body}) async {
    try {
      await _plugin.show(
        id: _completedId,
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

  @override
  Future<void> showOngoing({required String title, required String body}) async {
    try {
      await _plugin.show(
        id: _ongoingId,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _ongoingChannelId,
            'Workout in progress',
            channelDescription: 'Persistent reminder during a workout',
            importance: Importance.low,
            priority: Priority.low,
            ongoing: true,
            autoCancel: false,
            onlyAlertOnce: true,
            playSound: false,
            enableVibration: false,
            showWhen: false,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: false,
            presentSound: false,
            presentBadge: false,
            interruptionLevel: InterruptionLevel.passive,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) debugPrint('ongoing notif error: $e');
    }
  }

  @override
  Future<void> cancelOngoing() async {
    try {
      await _plugin.cancel(id: _ongoingId);
    } catch (_) {}
  }
}
