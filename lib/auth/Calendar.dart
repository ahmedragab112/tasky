import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final DateTime time;

  Event(this.title, this.time);
}


class Calendar extends StatefulWidget {
  // ignore: use_super_parameters
  const Calendar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // ignore: prefer_final_fields
  Map<DateTime, List<Event>> _events = {};
  // ignore: prefer_final_fields
  TextEditingController _eventController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _timeController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _eventController.dispose();
    _timeController.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = _getEventsForDay(selectedDay);
    });
  }

  void _addNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("Add Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _eventController,
                decoration: const InputDecoration(labelText: 'Note'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time (HH:MM)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_selectedDay != null &&
                    _eventController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  final timeParts = _timeController.text.split(':');
                  final hours = int.parse(timeParts[0]);
                  final minutes = int.parse(timeParts[1]);
                  final parse = DateTime(
                    _selectedDay!.year,
                    _selectedDay!.month,
                    _selectedDay!.day,
                    hours,
                    minutes,
                  );
                  final event = Event(
                    _eventController.text,
                    parse,
                  );
                  _events[_selectedDay!] = [
                    ...(_events[_selectedDay!] ?? []),
                    event
                  ];
                  _selectedEvents.value = _getEventsForDay(_selectedDay!);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _displayTodayNotes() {
    setState(() {
      _selectedDay = DateTime.now();
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _addNote,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16), // Add some spacing between buttons
          ElevatedButton(
            onPressed: _displayTodayNotes,
            child: const Text(' Today Notes'),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            headerStyle: const HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
            ),
            selectedDayPredicate: (DateTime date) {
              return isSameDay(_selectedDay, date);
            },
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        // ignore: avoid_print
                        onTap: () => print('${value[index]}'),
                        // ignore: unnecessary_string_interpolations
                        title: Text('${value[index].title}'),
                        subtitle: Text(
                          '${value[index].time.hour.toString().padLeft(2, '0')}:${value[index].time.minute.toString().padLeft(2, '0')}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
