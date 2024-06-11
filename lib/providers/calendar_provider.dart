import 'package:bicard_diplomka_01_/models/get_timetable_slots_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime? selectDate;
  Timeslots? time;
  int? id;
  String? userName;

  // Constructor to initialize userName
  CalendarProvider({this.userName});

  void setTime(Timeslots currentTime) {
    time = currentTime;
    notifyListeners();
  }

  void setSelectDate(DateTime currentSelectDate) {
    selectDate = currentSelectDate;
    notifyListeners();
  }

  String getDate() {
    return DateFormat("dd/MM/yyyy").format(selectDate!);
  }
}

