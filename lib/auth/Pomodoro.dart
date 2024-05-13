// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/colors.dart';
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

  late Timer _timer;
  bool _isWorking = true;
  bool _isStarted = false;
  int _currentDuration = _workDuration;
  int _pomodoroCounter = 0;

  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedTask; // Nullable type

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentDuration <= 0) {
          timer.cancel();
          setState(() {
            if (_isWorking) {
              _pomodoroCounter++;
              _currentDuration = _pomodoroCounter % 4 == 0
                  ? _longBreakDuration
                  : _shortBreakDuration;
              _isWorking = !_isWorking;
            } else {
              _currentDuration = _workDuration;
              _isWorking = !_isWorking;
            }
            _isStarted = false;
          });
        } else {
          setState(() {
            _currentDuration--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG,
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: Padding(
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
                        color: value == null ? Colors.black54 : Colors.black),
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  setState(() {
                    _currentDuration = newValue.toInt();
                  });
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'The more you focus,\nThe more you achieve.',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
