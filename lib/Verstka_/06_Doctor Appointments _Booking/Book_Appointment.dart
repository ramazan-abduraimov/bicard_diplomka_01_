import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Select_Hour.dart';
import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/calendar_widget.dart';
import 'package:provider/provider.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key? key  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectDate;

  @override
  void initState() {
    super.initState();
    _selectDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
              child: Column(
                children: [
                  CalendarWidget(
                    onChange: (DateTime value) async {
                      setState(() {
                        _selectDate = value;
                        context
                            .read<CalendarProvider>()
                            .setSelectDate(_selectDate);
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Select Hour",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const TimePicker(),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(28, 42, 58, 1),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all(const Size(380, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await ApiService().submitAppointment(
                        selectDate:
                            context.read<CalendarProvider>().selectDate ??
                                DateTime.now(),
                        time: context.read<CalendarProvider>().time?.time ??
                            "09:00",
                        id: context.read<CalendarProvider>().id ?? 1,
                      );
                      _congratulations();
                    },
                    child: const Text(
                      "Подтверить",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _congratulations() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 25, 20, 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("asset/images/gotovo.png",
                      width: 140, height: 140),
                  const SizedBox(height: 15),
                  const Text(
                    "Поздравляю!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    child: Text(
                      "Ваша встреча с доктором Дэвидом Пателем назначена на "
                      "\n${context.read<CalendarProvider>().getDate()} ${context.read<CalendarProvider>().time?.time}.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(28, 42, 58, 1),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all(const Size(80, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Сделано",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
