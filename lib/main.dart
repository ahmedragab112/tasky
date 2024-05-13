import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/Calendar.dart';
import 'package:foucesflow3/auth/Home.dart';
import 'package:foucesflow3/auth/Pomodoro.dart';
import 'package:foucesflow3/auth/Start.dart';
import 'package:foucesflow3/auth/challenge.dart';
import 'package:foucesflow3/auth/login.dart';
import 'package:foucesflow3/auth/notes.dart';
import 'package:foucesflow3/auth/notifications.dart';
import 'package:foucesflow3/auth/signup.dart';
import 'package:foucesflow3/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: '/',
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
