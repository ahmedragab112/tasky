import 'package:flutter/material.dart';

class notifications extends StatefulWidget {
  @override
  _notificationsState createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  bool _allNotificationsEnabled = true;
  bool _calendarNotificationsEnabled = true;
  bool _twentyOneDaysNotificationsEnabled = true;
  bool _pomodoroNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        children: [
          _buildSwitchTile(
            'Turn Off All Notifications',
            _allNotificationsEnabled,
                (value) {
              setState(() {
                _allNotificationsEnabled = value;
                _calendarNotificationsEnabled = value;
                _twentyOneDaysNotificationsEnabled = value;
                _pomodoroNotificationsEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            'Calendar Notifications',
            _calendarNotificationsEnabled,
                (value) {
              setState(() {
                _calendarNotificationsEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            '21-Days Notifications',
            _twentyOneDaysNotificationsEnabled,
                (value) {
              setState(() {
                _twentyOneDaysNotificationsEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            'Pomodoro Notifications',
            _pomodoroNotificationsEnabled,
                (value) {
              setState(() {
                _pomodoroNotificationsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
      String title,
      bool value,
      Function(bool) onChanged,
      ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
