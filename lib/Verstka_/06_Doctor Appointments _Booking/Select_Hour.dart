import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0, // Gap between buttons
      runSpacing: 10.0, // Gap between rows
      children: _generateTimeButtons(),
    );
  }

  List<Widget> _generateTimeButtons() {
    List<TimeOfDay> times = [];

    // Add times from 9:00 to 17:30
    for (int hour = 9; hour <= 16; hour++) {
      if( hour >=12  &&  hour <= 13 ) continue;
      times.add(TimeOfDay(hour: hour, minute: 0));
      times.add(TimeOfDay(hour: hour, minute: 30));
    }

    return times.map((time) {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedTime = time;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedTime == time ? Color.fromRGBO(28, 42, 58, 1) : Color.fromRGBO(249, 250, 251, 1),
          // Add more styling as needed
        ),
        child: Text(
          _formatTime(time),
          style: TextStyle(
            color: _selectedTime == time ? Colors.white : Colors.black,
            // Add more styling as needed
          ),
        ),
      );
    }).toList();
  }

  String _formatTime(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String amPm = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $amPm';
  }
}


