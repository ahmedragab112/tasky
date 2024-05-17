import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/colors.dart';
import 'package:foucesflow3/firebase/firebase_manger.dart';
import 'package:foucesflow3/models/chanlenge.dart';

class challenge extends StatefulWidget {
  const challenge({super.key});

  @override
  _challengeState createState() => _challengeState();
}

class _challengeState extends State<challenge> {
  final List<String> availableTopics = [
    'Self Love',
    'Read Book',
    'Workout',
    'Learning',
    'Routine',
    'Health',
    'Mental Health',
    'Lifestyle',
    'Productivity',
    'Positivity',
    'Personal Growth',
  ];

  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('21-Day Challenge'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            const Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'SpaceGrotesk',
                // fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'The 21-Day Challenge',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Courgette',
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'images/Pos2.jpg',
              height: 200,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StreamBuilder<QuerySnapshot<ChallengeCategory>>(
                            stream: FirebaseManger.retriveChallengesData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text("Something went wrong"));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<ChallengeCategory> challenges = snapshot
                                  .data!.docs
                                  .map((e) => e.data())
                                  .toList();

                              return SelectTopicsPage(
                                challenges: challenges,
                              );
                            }),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                // White background
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 25),
                side: const BorderSide(color: Color(0xFF014B3B)),
                // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
              child: const Text(
                'Select Topics',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'InriaSans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF014B3B), // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTopicsPage extends StatefulWidget {
  final List<ChallengeCategory> challenges;
  const SelectTopicsPage({super.key, required this.challenges});

  @override
  _SelectTopicsPageState createState() => _SelectTopicsPageState();
}

class _SelectTopicsPageState extends State<SelectTopicsPage> {
  // List of colors for checkboxes
  final List<Color> checkboxColors = [
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Topics'),
      ),
      body: ListView.builder(
        itemCount: widget.challenges.length,
        itemBuilder: (context, index) {
          final topic = widget.challenges[index];
          final colorIndex = index % checkboxColors.length;
          return ListView.builder(
              itemCount: topic.challenges.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    topic.challenges[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                  activeColor: checkboxColors[colorIndex],
                  checkColor: Colors.white,
                  value: widget.challenges.contains(topic),
                  onChanged: (value) {
                    setState(() {
                      value!
                          ? widget.challenges.add(topic)
                          : widget.challenges.remove(topic);
                    });
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.challenges.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListView.builder(
                      itemCount: widget.challenges.length,
                      itemBuilder: (context, index) {
                        return SelectedTopicsPage(
                          selectedTopics: widget.challenges[index].challenges,
                        );
                      })),
            );
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class SelectedTopicsPage extends StatelessWidget {
  final List<String> selectedTopics;

  const SelectedTopicsPage({super.key, required this.selectedTopics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Topics'),
      ),
      body: ListView.builder(
        itemCount: selectedTopics.length,
        itemBuilder: (context, index) {
          final topic = selectedTopics[index];
          return ListTile(
            title: Text(topic),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengePage(topic: topic),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChallengePage extends StatefulWidget {
  final String topic;

  const ChallengePage({super.key, required this.topic});

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late List<String> challenges;
  late List<bool> completedDays;

  @override
  void initState() {
    super.initState();
    data();
  }

  void data() async {
    completedDays =
        completedDaysState[widget.topic] ?? List.generate(21, (index) => false);
    challenges = await FirebaseManger.getChallengesForCategory(widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('21-Day Challenge for ${widget.topic}'),
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Day ${index + 1}: ${challenges[index]}'),
            trailing: completedDays[index]
                ? const Icon(Icons.check, color: Colors.green)
                : const Icon(Icons.close, color: Colors.red),
            onTap: () {
              if (index == 0 || completedDays[index - 1]) {
                _showConfirmationDialog(index);
              } else {
                _showAlertDialog();
              }
            },
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you completed the day?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  completedDays[index] = true;
                });
                completedDaysState[widget.topic] = completedDays;
                Navigator.of(context).pop();
              },
              child: const Text('Complete Challenge'),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('You must complete the previous day first'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }
}

Map<String, List<bool>> completedDaysState = {};
