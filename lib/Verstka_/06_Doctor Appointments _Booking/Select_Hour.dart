import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:bicard_diplomka_01_/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalendarProvider>();
    final DateTime? selectDate = state.selectDate;
    return FutureBuilder(
        future: ApiService().getDoctorAppointment(
          selectDate: selectDate ?? DateTime.now(),
          id: context.read<CalendarProvider>().id ?? 1,
        ),
        builder: (context, snapshot) {
          print(snapshot.error);
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
}

class SlotsWidgets extends StatefulWidget {
  final List<Timeslots> listSlot;

  const SlotsWidgets({super.key, required this.listSlot});

  @override
  State<SlotsWidgets> createState() => _SlotsWidgetsState();
}

class _SlotsWidgetsState extends State<SlotsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: _generateTimeButtons(),
    );
  }

  List<Widget> _generateTimeButtons() {
    final CalendarProvider state = context.watch<CalendarProvider>();
    return widget.listSlot.map((Timeslots? time) {
      return ElevatedButton(
        onPressed: time?.status == "booked"
            ? null
            : () {
                state.setTime(time!);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: state.time?.time == time?.time
              ? const Color.fromRGBO(28, 42, 58, 1)
              : const Color.fromRGBO(249, 250, 251, 1),
          // Add more styling as needed
        ),
        child: Text(
          time?.time.toString() ?? "9:00",
          style: TextStyle(
            color: state.time?.time == time?.time ? Colors.white : Colors.black,
            // Add more styling as needed
          ),
        ),
      );
    }).toList();
  }
}
