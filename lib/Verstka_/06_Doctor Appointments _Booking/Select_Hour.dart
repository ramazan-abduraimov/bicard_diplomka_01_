import 'dart:convert';

import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TimePicker extends StatefulWidget {
  final DateTime selectDate;

  const TimePicker({
    Key? key,
    required this.selectDate,
  }) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDoctorAppointment(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SlotsWidgets(listSlot: snapshot.data!.timeslots!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text("Подождите");
        });
  }

  Future<GetTimesModels?> getDoctorAppointment() async {
    var url = 'http://192.168.50.225:5297/api/Appointments/GetTimeSlots';
    var queryParams = {
      'currentDay':
          '${DateFormat("yyyy-MM-dd").format(widget.selectDate)}T00:00:00Z',
      'doctorId': '2',

    };
    print(queryParams);
    var uri = Uri.parse(url).replace(queryParameters: queryParams);
    try {
      var response = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      });
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetTimesModels? getTimesModels =
            GetTimesModels.fromJson(jsonDecode(response.body));
        return getTimesModels;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response.statusCode} -- ')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Не удалось создать учетную запись. Пожалуйста, повторите попытку позже.')),
      );
    }
    return null;
  }
}


class SlotsWidgets extends StatefulWidget {
  final List<Timeslots> listSlot;

  const SlotsWidgets({super.key, required this.listSlot});

  @override
  State<SlotsWidgets> createState() => _SlotsWidgetsState();
}

class _SlotsWidgetsState extends State<SlotsWidgets> {
  Timeslots? _selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: _generateTimeButtons(),
    );
  }

  List<Widget> _generateTimeButtons() {
    return widget.listSlot.map((time) {
      return ElevatedButton(
        onPressed: time.status == "booked"
            ? null
            : () {
                setState(() {
                  _selectedSlot = time;
                });
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedSlot == time
              ? const Color.fromRGBO(28, 42, 58, 1)
              : const Color.fromRGBO(249, 250, 251, 1),
          // Add more styling as needed
        ),
        child: Text(
          time.time ?? "9:00",
          style: TextStyle(
            color: _selectedSlot == time ? Colors.white : Colors.black,
            // Add more styling as needed
          ),
        ),
      );
    }).toList();
  }
}
