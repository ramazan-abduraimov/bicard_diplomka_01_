// import 'package:flutter/cupertino.dart';
//
// class CalendarProvider extends ChangeNotifier{
//   DateTime? selectDate;
//   Timeslots? time;
//
//   int? id;
//   setTime(Timeslots currentTime){
//     time = currentTime;
//     notifyListeners();
//   }
//
//   setSelectDate(DateTime currentSelectDate){
//     selectDate = currentSelectDate;
//     notifyListeners();
//   }
//
//   String getDate(){
//     return DateFormat("dd/MM/yyyy").format(selectDate!);
//   }
// }