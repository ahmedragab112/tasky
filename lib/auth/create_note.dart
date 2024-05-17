import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foucesflow3/models/task_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(TaskModel) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF4B4B4B), // Set primary color to black
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
              color: Color(0xFF4B4B4B)), // Set hint text color to black
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Note'),
          centerTitle: true,
          backgroundColor: const Color(0xFFD6D6D6),
          iconTheme: const IconThemeData(color: Color(0xFF4B4B4B)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                style: const TextStyle(color: Color(0xFF4B4B4B), fontSize: 28),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: bodyController,
                style: const TextStyle(color: Color(0xFF4B4B4B), fontSize: 18),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write Something..",
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFFD6D6D6),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleController.text.isEmpty) {
              return;
            }
            if (bodyController.text.isEmpty) {
              return;
            }

            final note = TaskModel(
              description: bodyController.text,
              title: titleController.text,
              date: DateTime.now().microsecondsSinceEpoch,
              userId: FirebaseAuth.instance.currentUser!.uid,
            );

            widget.onNewNoteCreated(note);
            Navigator.of(context).pop();
          },
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 8,
          child: const Icon(
            Icons.add,
            color: Color(0xFF4B4B4B),
            size: 24,
          ),
        ),
      ),
    );
  }
}
