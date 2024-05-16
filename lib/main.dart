import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foucesflow3/auth/Calendar.dart';
import 'package:foucesflow3/auth/Home.dart';
import 'package:foucesflow3/auth/Pomodoro.dart';
import 'package:foucesflow3/auth/Start.dart';
import 'package:foucesflow3/auth/challenge.dart';
import 'package:foucesflow3/auth/login.dart';
import 'package:foucesflow3/auth/notes.dart';
import 'package:foucesflow3/auth/notifications.dart';
import 'package:foucesflow3/auth/signup.dart';
import 'package:foucesflow3/constant.dart';
import 'package:foucesflow3/firebase/firebase_manger.dart';
import 'package:foucesflow3/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);

  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseManger.uploadChallengesData(challengesData);
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  String token = await FirebaseMessaging.instance.getToken() ?? 'no token';
  log(token);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/Home',
      routes: {
        '/': (context) => const Start(),
        // Navigate to Start Screen class
        '/login': (context) => const login(),
        // Navigate to Login class
        '/signup': (context) => const signup(),
        // Navigate to SignUp class
        '/Home': (context) => Home(),
        // Navigate to HomePage class
        '/Pomodoro': (context) => const Pomodoro(),
        // Navigate to Pomodoro class
        '/notes': (context) => const notes(),
        // Navigate to notes class
        '/notifications': (context) => notifications(),
        // Navigate to notifications class
        '/challenge': (context) => const challenge(),
        // Navigate to challenge class
        '/Calendar': (context) => const Calendar(
              title: '',
            ),
        // Navigate to Calendar class
        // '/FocusMode': (context) => const FocusMode(),
        // // Navigate to Calendar class
      },
    );
  }
}
