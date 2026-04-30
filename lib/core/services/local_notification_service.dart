import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  LocalNotificationService(this._notificationsPlugin);

 Future<void> init() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token"); 

    const AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    await _notificationsPlugin.initialize(
      settings: const InitializationSettings(android: android), 
      onDidReceiveNotificationResponse: (details) {
        print("User tapped on notification: ${details.payload}");
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showInstantNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened from background by notification: ${message.data}");
    });
  }
RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
if (initialMessage != null) {
  print("App opened from terminated state: ${initialMessage.data}");
}
}

  Future<void> showInstantNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

  await _notificationsPlugin.show(
  id: notification.hashCode,     
  title: notification.title,     
  body: notification.body,       
  notificationDetails: const NotificationDetails(
    android: AndroidNotificationDetails(
      'Castly Notification', 
      'Castly Reminder',
      importance: Importance.max,
      priority: Priority.high,
    ),
  ),
  payload: message.data.toString(),
);
  }
}