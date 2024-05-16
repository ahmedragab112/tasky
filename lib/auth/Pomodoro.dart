// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/Home.dart';
import 'package:foucesflow3/auth/colors.dart';
import 'package:foucesflow3/auth/congraturlation_page.dart';
import 'package:foucesflow3/auth/notes.dart';
import 'package:foucesflow3/firebase/firebase_manger.dart';
import 'package:foucesflow3/models/work_time_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static const int _workDuration = 25 * 60; // 25 minutes
  static const int _shortBreakDuration = 5 * 60; // 5 minutes break
  static const int _longBreakDuration = 15 * 60; // 15 minutes break

  Timer? _timer;
  bool _isWorking = true;
  bool _isStarted = false;
  int _currentDuration = _workDuration;
  int _pomodoroCounter = 0;
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedTask; // Nullable type
  final ValueNotifier<int> _pomodoroCounterNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentDuration <= 0) {
          timer.cancel();
          _handleTimerCompletion();
        } else {
          setState(() {
            _currentDuration--;
          });
        }
      },
    );
  }

  void _handleTimerCompletion() async {
    if (_isWorking) {
      _pomodoroCounter++;
      _pomodoroCounterNotifier.value = _pomodoroCounter;
      _currentDuration =
          _pomodoroCounter % 4 == 0 ? _longBreakDuration : _shortBreakDuration;
      _isWorking = !_isWorking;
    } else {
      _currentDuration = _workDuration;
      _isWorking = !_isWorking;
    }
    _isStarted = false;

    await FirebaseManger.addWorkTime(WorkTimeModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      longRestTime: convertSecondsToTime(_longBreakDuration.toString()),
      shortRestTime: convertSecondsToTime(_shortBreakDuration.toString()),
      rounds: _pomodoroCounter.toString(),
      workTime: convertSecondsToTime(_workDuration.toString()),
    ));

    setState(() {}); // Update UI state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG,
      appBar: AppBar(
        title: const Text('Pomodoro'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _pomodoroCounterNotifier,
        builder: (context, value, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pomodoroCounter >= 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CongratulationPage(
                    pageDescription: motivationWords[_pomodoroCounter],
                  ),
                ),
              );
            }
          });
          return child!;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: _selectedTask,
                  decoration: const InputDecoration(
                    labelText: 'Task:',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: <String?>[
                    null,
                    'Study',
                    'Work',
                    'Reading',
                    'Research',
                    'Writing',
                    'Coding/Programming',
                    'Language Learning',
                    'Designing',
                    'Exercise',
                    'Planning/Organizing',
                    'Others',
                  ].map((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value ?? 'Select Task',
                        style: TextStyle(
                            color:
                                value == null ? Colors.black54 : Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTask = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Description: optional',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  'Rounds: $_pomodoroCounter',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SleekCircularSlider(
                    initialValue: _currentDuration.toDouble(),
                    min: 0,
                    max: _isWorking
                        ? _workDuration.toDouble()
                        : (_pomodoroCounter % 4 == 0
                            ? _longBreakDuration.toDouble()
                            : _shortBreakDuration.toDouble()),
                    appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(
                        trackWidth: 15,
                        handlerSize: 20,
                        progressBarWidth: 15,
                        shadowWidth: 0,
                      ),
                      customColors: CustomSliderColors(
                        trackColor: Colors.grey,
                        progressBarColor: Pink,
                        hideShadow: true,
                        dotColor: Colors.white,
                      ),
                      size: 250,
                      angleRange: 360,
                      startAngle: 270,
                    ),
                    onChange: (double newValue) {
                      (newValue / 60).floor();
                      (newValue % 60).floor();
                      _currentDuration = newValue.toInt();
                      setState(() {});
                    },
                    innerWidget: (double newValue) {
                      final int minutes = (newValue / 60).floor();
                      final int seconds = (newValue % 60).floor();
                      return Center(
                        child: Text(
                          '$minutes:${seconds.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 46),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (!_isStarted) {
                        _isStarted = true;
                        _startTimer();
                      }
                    });
                  },
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 40,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    motivationWords[_pomodoroCounter],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertSecondsToTime(String secondsString) {
    int totalSeconds = int.tryParse(secondsString) ?? 0;
    int minutes = (totalSeconds ~/ 60) % 60;
    int seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

List<String> motivationWords = const [
  'The more you focus,\nThe more you achieve.',
  "Believe you can and you're halfway there.",
  "The only way to do great work is to love what you do.",
  "Success is not final, failure is not fatal: It is the courage to continue that counts.",
  "You are never too old to set another goal or to dream a new dream."
];
