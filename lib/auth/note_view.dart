import 'package:flutter/material.dart';
import 'package:foucesflow3/firebase/firebase_manger.dart';
import 'package:foucesflow3/models/task_model.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key, required this.note});

  final TaskModel note;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Note View",
                style: TextStyle(color: Color(0xFF4B4B4B))),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Color(0xFF4B4B4B)),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete This ?"),
                          content: Text("Note ${note.title} will be deleted!"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await FirebaseManger.deleteTask(note.id);
                                Navigator.pop(context);
                              },
                              child: const Text("DELETE"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("CANCEL"),
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color(0xFF4B4B4B),
                ),
              ),
            ],
            backgroundColor: const Color(0xFFD6D6D6)),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(color: Color(0xFF4B4B4B), fontSize: 26),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                note.description,
                style: const TextStyle(color: Color(0xFF4B4B4B), fontSize: 18),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255));
  }
}
