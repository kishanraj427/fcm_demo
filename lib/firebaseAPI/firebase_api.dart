import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../screens/show_noti_data.dart';

// Class for handling Notifications 
class FirebaseAPI {

  final firebaseMessaging = FirebaseMessaging.instance;
  final androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notifications",
      description: "This Channel is used for important notifications",
      importance: Importance.defaultImportance);
  
  final localNotification = FlutterLocalNotificationsPlugin();

  // Taking permission from user for notification and saving their FCM token into the database
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    
    // FCM Token for user's device
    String? fcmToken = await firebaseMessaging.getToken();
    print(fcmToken);

    initPushNotification();
    initLocalNotification();
  }

  // On clicking to notification, user redirected to Specific screen of the app
  void handleMessage(RemoteMessage message) {
    if (message == null)
      return;
    else {
      Get.to(ShowNotificationData(
          title: message.notification!.title!,
          message: message.notification!.body!,
          data: message.data,
      ));
    }
  }

  // Handling notification when app is not running.
  Future initPushNotification() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage(value!));

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackgroundMessage(message));

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              icon: "@drawable/ic_launcher",
            ),
            iOS: const DarwinNotificationDetails()
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  // Handling notification when app is running.
  Future initLocalNotification() async {
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(iOS: ios, android: android);
    await localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (value) {
        final message = RemoteMessage.fromMap(jsonDecode(value.payload!));
        handleMessage(message);
      },
    );
    final platform = localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform!.createNotificationChannel(androidChannel);
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification!.title}");
    print("Message: ${message.notification!.body}");
    print("Payload: ${message.data}");
  }
}
