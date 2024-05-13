// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/create_note.dart';
import 'package:foucesflow3/auth/note_card.dart';
import 'package:foucesflow3/auth/notes_page_model.dart';
import 'package:foucesflow3/firebase/firebase_manger.dart';
import 'package:foucesflow3/models/task_model.dart';

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes", style: TextStyle(color: Color(0xFF4B4B4B))),
        centerTitle: true,
        backgroundColor: const Color(0xFFD6D6D6),
        iconTheme: const IconThemeData(color: Color(0xFF4B4B4B)),
      ),
      body: StreamBuilder<QuerySnapshot<TaskModel>>(
        stream: FirebaseManger.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<TaskModel> tasks =
              snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
          return ListView.builder(
            itemBuilder: (context, index) => NoteCard(
              note: tasks[index],
            ),
            itemCount: tasks.length,
          );
        },
      ),
      backgroundColor: const Color(0xFFD6D6D6),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateNote(
                    onNewNoteCreated: onNewNoteCreated,
                  )));
        },
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 8,
        child: const Icon(
          Icons.add,
          color: Color(0xFF4B4B4B),
          size: 24,
        ),
      ),
    );
  }

  Future<void> onNewNoteCreated(TaskModel task) async {
    await FirebaseManger.addTask(task);
  }

  void onNoteDeleted(String id) async {
    await FirebaseManger.deleteTask(id);
  }
}
